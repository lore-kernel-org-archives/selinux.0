Date: Thu, 9 May 2002 09:59:21 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Davies, James E" <jedavie@sandia.gov>
cc: "'Selinux@tycho.nsa.gov'" <Selinux@tycho.nsa.gov>
Subject: Re: new selinux install
In-Reply-To: <B51F0C636E578A4E832D3958690CD73EBB102D@es04snlnt>
Message-ID: <Pine.GSO.4.33.0205090952211.1046-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 9 May 2002, Davies, James E wrote:

> I've just installed the selinux 2.4.(18) kernel on redhat 7.2 from the nsa
> site and have the following problems. All I've done so far is to add 2
> users. I have not modified any context or .te files yet.
>
> Most of the processes are labeled as type kernel_t with a sid of 1. I
> suppose this means they're not transitioning to their proper domain.
> AVC_toggle to enforcing mode hangs the system console session, forcing a
> reboot.

It doesn't look like you labeled the filesystem.  Did you follow the
complete installation instructions in selinux/README?   Run 'make relabel'
in selinux/policy and then reboot.

As a general note, when asking questions or reporting bugs, please
identify the particular release that you are using (e.g. 2002050211 is the
latest) and the download option that you used.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
