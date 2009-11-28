Subject: Re: [PATCH] Support for long-options in policycoreutils and
 checkpolicy (Ticket #1 [1672486])
From: Guido Trentalancia <guido@trentalancia.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <4B102369.6010407@manicmethod.com>
References: <1257206276.24413.26.camel@tesla.lan>
	 <4B07537B.7070204@tycho.nsa.gov> <1258841039.3002.214.camel@tesla.lan>
	 <4B101DAC.5080801@manicmethod.com>  <4B102369.6010407@manicmethod.com>
Content-Type: text/plain
Date: Sat, 28 Nov 2009 02:58:21 +0100
Message-Id: <1259373502.8296.7.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dear Joshua,

in your previous message you were also asking why the option "-V"
instead of "-v" has been used for getting the version of the program.
Again, this is according to the GNU coding style (because "-v" is
generally used for making the program "verbose").

Regards,

Guido

On Fri, 2009-11-27 at 14:07 -0500, Joshua Brindle wrote:
> Joshua Brindle wrote:
> > Guido Trentalancia wrote:
> >> Dear Eamon,
> >>
> >> here are the two "maintenance" patches that I did post earlier this
> >> month (along with the new manual pages). They are intended to close
> >> Ticket #1 [1672486] that I found open on Tresys pages
> >> (http://userspace.selinuxproject.org/trac/ticket/1).
> >>
> >> I do apologize for not putting the keyword "[PATCH]" in the original
> >> message.
> >>
> >> Here is a summary of what has been changed for policycoreutils:
> >>
> >> - introduced proper handling of -h, -V options and their respective long
> >> formats --help and --version to all binaries that are produced from C
> >> code. The same issue is not tackled for Python-based tools (e.g.
> >> semanage);
> >> - relative manual pages have also been updated accordingly.
> >>
> >> And here is what has been changed for checkpolicy/checkmodule:
> >>
> >> - introduced proper handling of -h, -V and the long formats --help and
> >> --version to all binaries (checkpolicy/checkmodule);
> >> - introduced the handling of long options for some of the other
> >> available options;
> >> - manual pages have also been updated accordingly (and a few
> >> undocumented options have been documented).
> >>
> >> One of the original two patches (the one against policycoreutils) did
> >> not compile cleanly anymore against the current HEAD of SELinux, so I
> >> have created an updated one, which is the one attached here.
> >>
> >> It's just a matter of some really minor issues, but I hope it helps, at
> >> least the ticket can now be closed...
> >>
> >> Kind regards,
> >>
> >> Guido
> >>
> >
> >
> > Thank you for doing this. Unfortunately it looks like your mail client
> > decided to base64 encode the attachment.
> >
> > It is always best to use git to generate patch emails, please see:
> > http://andrewprice.me.uk/weblog/entry/generating-patch-emails-with-git
> >
> 
> I also have a couple comments about this patch. First I'm not so sure 
> about the:
> "[program name] version [version]."
> 
> format. For people to be able to test versions in shell scripts I think 
> the output should simply be the version.
> 
> I'm not sure what the "libtool" hack thing is all about, why is that 
> necessary? In fact I'm not sure what the whole opt_program_name thing is 
> about, what are you trying to address here? That change makes the patch 
> very messy since you are going through and replacing every occurrence of 
> argv[0] with program_name. Typically changes should be separated in 
> patches to ease review, I'm not sure what this has to do with adding 
> --version to the apps.
> 
> Also, why -V rather than -v ?
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
