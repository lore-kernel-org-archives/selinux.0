Date: Tue, 11 Dec 2001 08:32:58 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Johan Camp <johan.camp@student.kuleuven.ac.be>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: problems after installing selinux
In-Reply-To: <3C152F3D.A17A8DC1@student.kuleuven.ac.be>
Message-ID: <Pine.GSO.4.33.0112110830440.13843-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 10 Dec 2001, Johan Camp wrote:

> - when entering the 'ls --context' command I get the message "Sorry,
> --context can be used only on a flask-enabled kernel".
>
> - when entering the 'ps -e --context' command, all processes have SID =
> 3 and CONTEXT = -
>
> Can anyone tell me how I can solve this problem?

This indicates that the SELinux module isn't registered.  Check your
kernel configuration and make sure that you enabled SELinux as built-in.
Also check your /var/log/messages file or 'dmesg' output to see if there
were any errors during initialization.  As a side note, there is a newer
release now, but the old release should work for you as well.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
