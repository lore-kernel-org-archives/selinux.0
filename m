Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9Q7lFjn001920
	for <selinux@tycho.nsa.gov>; Sun, 26 Oct 2008 03:47:16 -0400
Received: from etbe.coker.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9Q7l8b5017954
	for <selinux@tycho.nsa.gov>; Sun, 26 Oct 2008 07:47:14 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Mike Edenfield <kutulu@kutulu.org>
Subject: Re: RFC: changing the "+" in ls -l output to be "." or "+"
Date: Sun, 26 Oct 2008 18:46:54 +1100
Cc: Jim Meyering <jim@meyering.net>,
        Vikram Noel Ambrose <noel.ambrose@gmail.com>, bug-coreutils@gnu.org,
        selinux@tycho.nsa.gov, 472590@bugs.debian.org,
        =?utf-8?q?Ond=C5=99ej_Va=C5=A1=C3=ADk?= <ovasik@redhat.com>
References: <200803251523.34329.russell@coker.com.au> <87mygumq37.fsf@rho.meyering.net> <4901CB4B.3030306@kutulu.org>
In-Reply-To: <4901CB4B.3030306@kutulu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200810261846.58879.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 25 October 2008 00:19, Mike Edenfield <kutulu@kutulu.org> wrote:
> Jim Meyering wrote:
> > A desire for compatibility makes "+" look good.
> > "." is appealing for SELinux-only because it's inconspicuous.
>
> Speaking as a fairly new SELinux user/admin, having a "."
> next to every file in my ls output is just as useful or
> non-useful as having a "+" next to them, so does it really
> buy anything?  I end up needing -Z either way.

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=472590

The above URL has the history of this discussion.  I requested that there be 
no such notification.  I still believe that there should be nothing used in 
the case of SE Linux (although I could be convinced that the "." is OK if 
files with the context "system_u:object_r:file_t:s0" did not have it).

But it seems that I have lost this debate.  Using "." is better than "+", and 
my request to have none of this in Lenny has been accepted so we have some 
time to work on this before Lenny+1.

> Based on the kind of real-world problems I've had, the most
> useful thing ls could tell me about a file on my SELinux
> system would be that it *should* have a label and *doesn't*,
> something like:
>
> if ( selinux_enabled )
>    if ( label == NULL || label == fs.defaultlabel )
>      use "!"
>    else
>      use " "
> else if ( anything else )
>    use "+"

That sounds quite reasonable.

-- 
Russell Coker <russell@coker.com.au>
http://etbe.coker.com.au/          My Blog
http://etbe.coker.com.au/category/security/  My Security blog posts
http://www.coker.com.au/selinux/play.html  My Play Machine, root PW "SELINUX"

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
