From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: useradd
Date: Sat, 24 Oct 2009 00:43:22 +1100
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200910211552.49980.russell@coker.com.au> <1256128210.4061.173.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1256128210.4061.173.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200910240043.25101.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 21 Oct 2009, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> The useradd in shadow-utils is already modified to:
> a) To add the user to seusers via semanage if the -Z option is used to
> specify a SELinux user, and
> b) set the fscreate context based on matchpathcon() for the user home
> dir prior to creating the files there.
>
> So it should already do the right thing.

I had forgotten that useradd in Debian is different from useradd in Fedora.  
Thanks for letting me know that the Fedora version does what is required.

I'll port the changes to Debian when I get time.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
