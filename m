Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6PCmwGN020652
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2011 08:49:01 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p6PCmw3a023748
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2011 12:48:59 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: apol and active modules
Date: Mon, 25 Jul 2011 22:48:54 +1000
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
References: <201107242126.19144.russell@coker.com.au> <4E2D6356.1070007@tresys.com>
In-Reply-To: <4E2D6356.1070007@tresys.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201107252248.55086.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 25 Jul 2011, "Christopher J. PeBenito" <cpebenito@tresys.com> wrote:
> On 07/24/11 07:26, Russell Coker wrote:
> > Why can't apol (at least version 3.3.6.ds) parse the files in
> > /etc/selinux/$SELINUXTYPE/modules/active/modules?  Is this considered a
> > bug or a wontfix thing?
> 
> Can you be more specific about your usage?  There shouldn't be a problem
> looking at those, since they're just a copy of what you install via
> semodule -i/-b.

# diff /usr/share/selinux/default/base.pp \ 
/etc/selinux/default/modules/active/base.pp 
Binary files /usr/share/selinux/default/base.pp and 
/etc/selinux/default/modules/active/base.pp differ

The files are not just a copy.

When /tmp/base.pp is a copy of /etc/selinux/default/modules/active/base.pp I 
get the following:

$ apol  /tmp/base.pp 
Initializing libqpol... done.
Initializing libapol... done.
Initializing libsefs... done.
Initializing libapol_tcl... done.
Initializing Tk... done.
(unknown source)::ERROR 'syntax error' at token 'BZh91AY' on line 1:

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
