Subject: Re: Reloading Policy?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: John Buwa <sales@michianawireless.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200503230636.j2N6aXYi025308@unix2.michianawireless.com>
References: <200503230636.j2N6aXYi025308@unix2.michianawireless.com>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 08:28:20 -0500
Message-Id: <1111584500.21107.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-03-23 at 01:41 -0800, John Buwa wrote:
> I have selinux on my fedora core 3 install. I need to reload the policy but
> can not figure out how. I read all the faq's and such stating 'make load' in
> the policy directory. However I do not have this directory by default nor
> the source. This came installed with the distro. I have rebooted and still
> the changes have not taken effect.

You can load a new binary policy file using the load_policy command,
e.g.
	/usr/sbin/load_policy /etc/selinux/targeted/policy/policy.18

If you need to customize policy, you can modify the policy sources and
then build and load a new policy using 'make load' in the policy source
directory, e.g.
	cd /etc/selinux/targeted/src/policy
	make load

If your system doesn't have the policy sources installed (not installed
by default on Fedora), then you can grab the RPM from the CD and install
it with rpm or just use yum to get the latest one, e.g.
	yum install selinux-policy-targeted-sources

Naturally, you'll want to yum update as well to get all updates for FC3
since the release.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
