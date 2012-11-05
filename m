Message-ID: <5097F234.70606@tycho.nsa.gov>
Date: Mon, 05 Nov 2012 12:07:00 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: With systemd taking care of starting services, is there any reason
 to continue to ship run_init?
References: <5097EE9C.6020104@redhat.com>
In-Reply-To: <5097EE9C.6020104@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/05/2012 11:51 AM, Daniel J Walsh wrote:
> systemctl start SERVICE
>
> Will start the service cleanly as the correct context, I want to remove this
> command from systemd enabled systems.  Any one know of a reason to not do this?

No, sounds right to me.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
