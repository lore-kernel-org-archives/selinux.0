Subject: Re: SE Linux file system relabel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <CAFftDdonw_shpO3o1+AE0aYH5gaWBPQxP_=jW4x6-fVXsz6pug@mail.gmail.com>
References: 
	 <CAFftDdonw_shpO3o1+AE0aYH5gaWBPQxP_=jW4x6-fVXsz6pug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 19 Mar 2012 08:14:43 -0400
Message-ID: <1332159283.23035.4.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2012-03-17 at 14:45 -0700, William Roberts wrote:
> I just stood SE Android up on a Maguro device. I have reviewed the
> patches submitted to the mailing list, but I would like to understand
> how to do some of this myself. I am trying to label the /factory
> files, currently the factory files are labeled as:
> 
> drwxrwxr-x radio    radio             u:object_r:unlabeled:s0 factory
> 
> 
> I modified sepolicy/attributes and included this line:
> 
> 
> #All types used for /factory files.
> attribute factory_type;
>  
> I then created sepolicy/factory.te file that is this:
> type factory, factory_type;
> 
> 
> 
> I then modified sepolicy/file_contexts to include
> # factory files
> /factory(/.*)?  u:object_r:factory:s0
> 
> 
> I am trying to figure out how to label that part of the filesystem
> from scratch so I can understand the process a little better. Thanks
> for any help!

Note that Bryan Hinton's patch for init.tuna.rc added restorecon
commands for /factory and its files.  Or you can run the same commands
from an adb shell.  restorecon is a new toolbox command and a new init
built-in command.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
