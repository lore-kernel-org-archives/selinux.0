Date: Mon, 10 Dec 2001 16:12:11 -0800
From: Paul Krumviede <pwk@acm.org>
To: Johan Camp <johan.camp@student.kuleuven.ac.be>, SELinux@tycho.nsa.gov
Subject: Re: problems after installing selinux
Message-ID: <190091447.1008000731@localhost>
In-Reply-To: <3C152F3D.A17A8DC1@student.kuleuven.ac.be>
References: <3C152F3D.A17A8DC1@student.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--On Monday, 10 December, 2001 22:55 +0100 Johan Camp 
<johan.camp@student.kuleuven.ac.be> wrote:

> Hi
>
> I recently installed selinux (the 2.4-14-lsm kernel) on my SuSE 7.2
> system. After compiling and installing the kernel and all other
> utilities (exactly as described in the selinux/README file). I have the
> folowing problem:
>
> - when entering the 'ls --context' command I get the message "Sorry,
> --context can be used only on a flask-enabled kernel".
>
> - when entering the 'ps -e --context' command, all processes have SID =
> 3 and CONTEXT = -
>
> Can anyone tell me how I can solve this problem?

this is what happens when a non-selinux kernel is booted. did you
fix up /etc/lilo.conf and run lilo to make sure the new kernel is
available at boot time?

-paul


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
