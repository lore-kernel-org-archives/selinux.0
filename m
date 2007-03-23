Subject: Re: BusyBox: load_policy applet
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
Cc: busybox@busybox.net, busybox@kaigai.gr.jp, vda.linux@googlemail.com,
        selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <20070323151513.395798cf.ynakam@hitachisoft.jp>
References: <20070323151513.395798cf.ynakam@hitachisoft.jp>
Content-Type: text/plain
Date: Fri, 23 Mar 2007 08:49:37 -0400
Message-Id: <1174654177.31436.188.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 15:15 +0900, Yuichi Nakamura wrote:
> Attached patch is to support load_policy for BusyBox.
> load_policy is a program to load SELinux policy to kernel.
> This applet is very important for SELinux, 
> because SELinux is not activated until policy is loaded.
> 
> And this applet is _not_ based on latest load_policy, 
> is based on old load_policy.
> This is because the size of latest load_policy is bigger than old one,
> and old load_policy has enough feature for embedded device.

Hmm...are you sure?  Functionality that you are losing from the new load
policy logic that lives in libselinux these days:
- automatic discovery of the right policy file,
- automatic downgrading of the policy file format to the kernel
supported format if necessary (e.g. new policy, old kernel),
- loading of local user and/or boolean definitions (obsolete if you
choose to use libsemanage and managed policy, but not clear you are
doing that in embedded),
- preservation of boolean settings across a policy reload so they aren't
reset to the policy defaults.

Boolean management seems the greatest concern, and using policy booleans
on an embedded device to change policy states based on events /
environmental factors is quite reasonable.

I know that you have a concern about libsepol size, but we may be able
to reduce that to a minimal subset for your purposes without dropping it
altogether on embedded (and it is expected to get smaller anyway as as
result of the proposed new policy representation).

As a minor point on your applet, shouldn't you munmap and close before
returning?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
