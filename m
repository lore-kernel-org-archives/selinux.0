Date: Tue, 15 Oct 2002 13:57:52 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Eric Gingras (LMC)" <Eric.Gingras@ericsson.ca>
cc: "SELinux Mailing list (E-mail)" <SELinux@tycho.nsa.gov>
Subject: Re: terminals permissions
In-Reply-To: <7B2A7784F4B7F0409947481F3F3FEF8304ACC384@eammlnt051.lmc.ericsson.se>
Message-ID: <Pine.GSO.4.33.0210151355240.26324-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 15 Oct 2002, Eric Gingras (LMC) wrote:

> I'm trying to give to some domains access to terminal writing... without
> success.
>
> In "enforcing" mode, when I execute ifconfig or ping nothing is written to
> the current terminal in answer.  Is that normal behavior ?
>
> How can I give my applications permission to write to the terminal.
>
> PS: I've try :
>                allow ifconfig_t sysadm_tty_device_t:chr_file rw_file_perms;
>                allow ifconfig_t sysadm_devpts_t:chr_file rw_file_perms;

Those rules are already in the example policy, in ifconfig.te.
Check the type on your terminal device, e.g.
ls --context `tty`

Are you running ifconfig and ping from a sysadm_r:sysadm_t shell?
What does the SELinux-patched 'id' program show when you run it from your
shell?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
