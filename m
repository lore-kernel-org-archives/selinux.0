Message-ID: <3F89E077.9030802@cisco.com>
Date: Sun, 12 Oct 2003 16:15:03 -0700
From: Michael Reilly <michaelr@cisco.com>
MIME-Version: 1.0
To: lky <lky77@sjtu.edu.cn>
CC: SELINUX <SELinux@tycho.nsa.gov>
Subject: Re: can't start X window in enforce mode
References: <000901c390ef$d8b3c770$5d38a8c0@lky>
In-Reply-To: <000901c390ef$d8b3c770$5d38a8c0@lky>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I had both problems.  I added the dontaudit memory devices
as mentioned in the file macros/program/xserver_macros.te.

I have the second problem and have not yet solved it.  Nothing is logged
and I cannot figure out what is wrong.

BTW - on my system /dev/tty0 is the same file as dev/console (both 4,0).
The man page indicates that it should be this way.  I tried labeling
/dev/tty0 as console_device_t (like /dev/console) but that did not help.

michael
lky wrote:
> Hi, I have eliminated all the denied messages in permissive mode. But when I change to the enforce mode I can't start X window now.The error message is below:
> -----------------------------------------------------------------------------------------
> ...............
> (EE) NV(0): Cannot open /dev/mem
> ................
> Fatal server error:
> xf86MapVidMem: failed to open /dev/mem (Permission denied)
> ................
> XIO:  fatal IO error 104 (Connection reset by peer) on X server ":0.0"
>       after 0 requests (0 known processed) with 0 events remaining.
> -----------------------------------------------------------------------------------------
> Why the system didn't display the denied message if the opration violate the policy? How should I configure my policy in order to start the X window?
> Thanks! 

-- 
---- ---- ----
Michael Reilly    michaelr@cisco.com
    Cisco Systems, Santa Cruz, CA


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
