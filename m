Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0U5AtXf029234
	for <selinux@tycho.nsa.gov>; Mon, 30 Jan 2006 00:10:56 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0U5AqlL006003
	for <selinux@tycho.nsa.gov>; Mon, 30 Jan 2006 05:10:53 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Lorenzo =?utf-8?q?Hern=C3=A1ndez_Garc=C3=ADa-Hierro?= <lorenzo@gnu.org>
Subject: Re: labeling of compilers etc
Date: Mon, 30 Jan 2006 16:10:42 +1100
Cc: SELinux List <selinux@tycho.nsa.gov>
References: <200601291156.13076.russell@coker.com.au> <200601301003.17498.russell@coker.com.au> <1138580807.9012.52.camel@estila>
In-Reply-To: <1138580807.9012.52.camel@estila>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200601301610.50252.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 30 January 2006 11:26, Lorenzo Hernández García-Hierro 
<lorenzo@gnu.org> wrote:
> > What do you consider to be the issues relating to tar etc?
>
> I'm generally talking about binfmt/file parsing risks. 'tar' shouldn't
> be able to do anything more than what it has been designed for.

When run by a user tar needs to be able to create and overwrite files in that 
user's home directory.

The same user needs to be able to edit their .bashrc file etc.

To achieve both these goals while not allowing tar to write to .bashrc (which 
seems to fit "anything more than what it has been designed for") then 
the .bashrc file would need a different type.  This would involve lots of 
extra pain and therefore is not something that I think is viable at this 
time.

While changes to shell interpreters will require some coding work, I think 
that they will be much more acceptable to the users and therefore more 
acceptable into mainstream distributions such as Fedora Core, Red Hat 
Enterprise Linux, and Debian.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
