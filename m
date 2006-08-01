Message-ID: <44CF5A49.2020703@redhat.com>
Date: Tue, 01 Aug 2006 09:42:33 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@redhat.com>, James Morris <jmorris@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Any idea why /proc/mtrr is marked as mtrr_device_t?
References: <44CF54EE.7040202@redhat.com> <1154438882.3582.79.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1154438882.3582.79.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> See Documentation/mtrr.txt in the kernel tree.
>
>   
So labeling a file as a device_t is ok?

In strict policy xserver wants to write to it

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
