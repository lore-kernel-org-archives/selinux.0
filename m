Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Warren Lerner <wdl@zai.com>, SELinux@tycho.nsa.gov
Subject: Re: AVC Messages
Date: Mon, 17 Jun 2002 21:14:03 +0200
References: <1024335869.3489.8.camel@montyburns>
In-Reply-To: <1024335869.3489.8.camel@montyburns>
MIME-Version: 1.0
Message-Id: <20020617191403.4121014BB@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 17 Jun 2002 19:44, Warren Lerner wrote:
> 1.  Is it possible to prevent the avc 'granted' or 'denied' messages
> off?  If so, how?

There is no way to turn them all off.  You can put in rules that match large 
numbers of them though, consider the following:
dontaudit domain file_type:{ file lnk_file fifo_file } create_file_perms;
dontaudit domain file_type:dir create_dir_perms;

But that's probably not what you really want.  When you put SE Linux in 
enforcing mode it's a real PITA to have things not work and no messages to 
explain why (I recently had some problems when I put in dontaudit rules for 
almost every action on /tmp and then X stopped working).

As for granted, avc_toggle is the only thing (AFAIK) that gets granted 
without you explicitely requesting it.

> 2.  Can I write my own policy file from scratch and use only the
> functions necessary for my purpose?

Sure!

> 3.  Will SELinux be incorporated in to the next kernel release?

I doubt it.  But hopefully LSM will be, and once your kernel has the base LSM 
code SE Linux will apply cleanly and easily.

I would prefer to see SE Linux stay out of the main kernel (for several 
reasons) and see just LSM go in.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
