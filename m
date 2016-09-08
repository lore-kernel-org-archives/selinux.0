From: "Roberts, William C" <william.c.roberts@intel.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, "seandroid-list@tycho.nsa.gov"
 <seandroid-list@tycho.nsa.gov>, "jwcart2@tycho.nsa.gov"
 <jwcart2@tycho.nsa.gov>
Subject: RE: [PATCH v2] libselinux: clean up process file
Date: Thu, 8 Sep 2016 19:44:41 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5601290179@ORSMSX103.amr.corp.intel.com>
References: <1473206821-30222-1-git-send-email-william.c.roberts@intel.com>
 <513c68e1-06e5-570d-3106-cf033b1e3040@tycho.nsa.gov>
 <476DC76E7D1DF2438D32BFADF679FC560128FA5C@ORSMSX103.amr.corp.intel.com>
 <6844a077-03c2-48ad-3e97-12572f1d5b68@tycho.nsa.gov>
In-Reply-To: <6844a077-03c2-48ad-3e97-12572f1d5b68@tycho.nsa.gov>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Thursday, September 8, 2016 12:41 PM
> To: Roberts, William C <william.c.roberts@intel.com>; selinux@tycho.nsa.gov;
> seandroid-list@tycho.nsa.gov; jwcart2@tycho.nsa.gov
> Subject: Re: [PATCH v2] libselinux: clean up process file
> 
> On 09/08/2016 03:30 PM, Roberts, William C wrote:
> > <snip>
> >
> >>>> +	/* Append any given suffix */
> >>>> +	char *to = stpcpy(&current[current_size], ".");
> >>>
> >>> Simpler as:
> >>> 	char *to = current + current_size;
> >>> 	*to++ = '.';
> >>
> >> I don't think this is simpler, but I'll do it.
> >
> > Doing that as is gets us this:
> > ==26050== Conditional jump or move depends on uninitialised value(s)
> > ==26050==    at 0x4C2DD9A: strcat (in /usr/lib/valgrind/vgpreload_memcheck-
> amd64-linux.so)
> > ==26050==    by 0x4E4B6D8: rolling_append (label_file.c:429)
> > ==26050==    by 0x4E4B8A3: open_file (label_file.c:472)
> > ==26050==    by 0x4E4BAC6: process_file (label_file.c:519)
> > ==26050==    by 0x4E4BE6D: init (label_file.c:582)
> > ==26050==    by 0x4E4D02B: selabel_file_init (label_file.c:965)
> > ==26050==    by 0x4E481F5: selabel_open (label.c:340)
> > ==26050==    by 0x4E513E0: matchpathcon_init_prefix (matchpathcon.c:322)
> > ==26050==    by 0x4E51725: matchpathcon (matchpathcon.c:413)
> > ==26050==    by 0x400D86: printmatchpathcon (matchpathcon.c:26)
> > ==26050==    by 0x40141F: main (matchpathcon.c:196)
> >
> > Because strcat() needs to fastforward to the null byte, this would
> > need to change to an strcpy.
> 
> Yes, sorry - switch the strcat() to strcpy() too.  Simpler and more efficient, and if
> you had to append further components, you could use
> stpcpy() rather than strcpy() each time until the last one.
> 
FYI: That change actually dropped off aprox 100 bytes on the obj code.
