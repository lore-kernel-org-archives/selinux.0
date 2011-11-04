From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Bhargava Shastry <bshas3@gmail.com>
Subject: Re: SELinux on Android
Date: Fri, 4 Nov 2011 21:54:03 +1100
Cc: SELinux@tycho.nsa.gov
References: <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com>
In-Reply-To: <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201111042154.04105.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 4 Nov 2011, Bhargava Shastry <bshas3@gmail.com> wrote:
> I am trying to get SELinux running on an Android phone. I did successfully
> build the kernel with SELinux enabled and mounted selinuxfs on init. Now, I
> would like to port SELinux user-space tools for policy loading/management.
> I looked at sebusybox tool-set but ran into problems while compiling. My
> hunch is that header files related to File System extended attributes are
> missing in the bionic lib sources that Android builds on. Having said that
> I have patched the Android YAFFS FS with an Xattr patch and also configured
> the kernel accordingly.

It's great that you got the kernel and filesystem code working as desired.  
Would it be possible to publish the binaries so that others can work on this 
too?  If you were to blog about this it would be good too.

As for the compile problem, it would really help if you could provide us the 
exact error messages from the compiler.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
