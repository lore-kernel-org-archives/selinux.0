Date: Mon, 26 Aug 2002 09:48:16 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: openssh
In-Reply-To: <1030367830.29149.25.camel@phobos>
Message-ID: <Pine.GSO.4.33.0208260944120.10972-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 26 Aug 2002, Timothy Wood wrote:

> After installing the version of ssh that comes with SELinux I am unable
> to connect to the machine.  I've followed the instructions in the
> README.privsep to make sure everything is setup and still nothing.  I
> tried a make install to reinstall it and I noticed that the install
> reports that the sshd user is not setup despite the fact that it does
> output the user id information for the sshd user when it calls id sshd
> from the script.  There are no avc or log messages generated (other than
> the normal ssh connect failed message) in enforcing or permissive mode.
> I'd assume that this is a problem installing ssh since it doesn't even
> work in permissive mode.  Any ideas as to what I've done wrong?

I assume that you restarted sshd (either by rebooting or by running
run_init /etc/init.d/sshd restart)?  Are you using the latest release
(2002082308, 23 August 2002) or the previous one (2002070313, 3 July
2002)?  Did you download from the NSA SELinux web site or the sourceforge
CVS tree?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
