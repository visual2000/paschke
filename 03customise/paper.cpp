#include	<windows.h>
#include 	<string.h>
#include	<ctype.h>
#include	<stdio.h>

void errormsg (int, char *) ;

int PASCAL WinMain(HINSTANCE hInst, HINSTANCE hPrevInstance,
                   LPSTR  lpszCmdParam, int nCmdShow)
{
	char *p, *q;
	FILE *fp;
	int TILE = 0,
	    STRETCH = 1;
	int endquote = 1;

	p = lpszCmdParam;
	if ((*p == '-')||(*p =='/')) {
		p++;
		switch (*p++) {
			case 'c':
			case 'C':
				TILE = 0;
				STRETCH = 0;
				break;
			case 's':
			case 'S':
				TILE = 0;
				STRETCH = 1;
				break;
			case 't':
			case 'T':
				TILE = 1;
				STRETCH = 0;
				break;
			default:
			errormsg(0,
"paper version 2.1\n"
"This program will make a bmp file the current wallpaper.\n"
"\nUsage: paper [OPTIONS] FILE\n"
"\nOptions:\n"
"\t-c, Center wallpaper.\n"
"\t-h, Help.\n"
"\t-s, Stretch wallpaper. (default)\n"
"\t-t, Tile wallpaper.\n\n"
"The option must precede the file name.  The program assumes the first non whitespace character after the option to the end of the command line is the file name, unless the filename begins with a quote.  Because of this behaviour, it doesn't issue an error if you include a second option, but it won't be interpreted.  The file name may be placed in quotes, but in this instance the second quote will be the end of the file name, so quotes may not be embedded in the file name.  The length of the file name including path cannot exceed 255 characters.  Options may be upper or lower case, preceded by a '/' or '-'.  This program ignores Active Desktop, if it doesn't work, try turning off Active Desktop.  You can remove the wallpaper by not passing a filename or options.\n"
"\n"
"This is free software.  You may redistribute copies under the terms of the GNU General Public License version 3 <http://www.gnu.org/licenses/gpl.html>.  There is NO WARRANTY, to the extent permitted by law.\n"
"\nCopyright July 2, 2007  Michael J. Chappell\n"
"mcsuper5@freeshell.org  http://mcsuper5.freeshell.org/\n"
);
return 0;
				break;
		}
		for ( ; isspace(*p) ; p++ ) ;
	}
	if (*p=='\"') { /* strip quotes */
		endquote = 0;
		for (q=p+1; *q; q++)
			if (*q=='\"') {
				*q='\0';
				endquote = 1;
				break;
			} /* if end quote */
		p++;
		if (! endquote) {
			errormsg(2,"\nNo closing quote found, terminating!\n");
			return 2;
		} /* no endquote */
	} /* strip quotes */
	if (strlen(p)>255) {
		errormsg(3, "\nPath too long, terminating!\n");
		return 3;
	}
	if (strlen(p)) if (fp = fopen(p, "r")) fclose (fp); else {
		errormsg(4, "\nFile not found, terminating!\n");
		return 4;
	}
	WriteProfileString("DeskTop", "TileWallPaper", TILE ? "1":"0");
	WriteProfileString("DeskTop", "WallPaperStyle", STRETCH ? "2":"0");
	SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, p,
		SPIF_UPDATEINIFILE|SPIF_SENDWININICHANGE);
	return 0;
}

void errormsg( int errornumber, char *errormessage ) {
/*	printf(errormessage); */
	MessageBox(0, errormessage, "Paper version 2.1", MB_OK);
	exit (errornumber);
	return; 
}

