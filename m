From: "Lamont R. Peterson" <lrp@xmission.com>
Reply-To: lrp@xmission.com
To: Stephen Smalley <sds@epoch.ncsc.mil>,
   Christof Rath <rath@sbox.tu-graz.ac.at>
Subject: Re: installing SELinux on Trustix
Date: Thu, 17 Apr 2003 12:35:46 -0600
Cc: SELinux@tycho.nsa.gov
References: <000801c303a8$4622a310$3700a8c0@wind> <1050508220.1143.21.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1050508220.1143.21.camel@moss-huskers.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304171235.46749.lrp@xmission.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christof:

<SNIP>

On Wednesday 16 April 2003 09:50 am, Stephen Smalley wrote:
> Boot with your old kernel and follow the step-by-step instructions for
> installing SELinux, since the quickinstall aborted for you.

It sounded like you might not have that old kernel installed still.  For just 
such situations, I always test new kernels using a separate boot selection 
first, without changing my default.  Personally, I like lilo better than 
grub, so I will use that "terminology".

I create a section in my lilo.conf that looks like this:
	image = /boot/bzImage.test
	root = /dev/[whatever your root partition is]
	label = Test
	read-only
	append = "[which whatever boot option(s) you need to pass to the kernel]"
	optional

Then, all I have to do move my testing kernel to /boot/bzImage.test and run 
lilo.  I boot it, test it and so on until I am happy with it.  Then I rename 
it bzImage (usually moving the old to bzImage.YYYY-MM-DD, run lilo and I am 
set!

Now, if you can not boot, then I might suggest you go to 
http://www.gentoo.org/ and get one of the installation iso images.  The 
1.4_rc? series are just great.  You can just download the smallest one.  Burn 
the CD and boot with it.  There is a file named INSTALL.TXT (if I am 
remembering correctly) in the root of the CD that is helpful.  This makes a 
super emergency/recovery/diagnostic CD to use.  Keep it handy when you need 
to fix other people's linux installs, whether or not they are Gentoo.

Hope that helps some of you out there.
-- 
Sincerely,
Lamont R. Peterson <lrp@xmission.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
