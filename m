Subject: Re: removing a module
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <874986.66361.qm@web51507.mail.re2.yahoo.com>
References: <874986.66361.qm@web51507.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Thu, 25 Oct 2007 14:16:56 -0400
Message-Id: <1193336216.2683.272.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-10-25 at 09:11 -0700, Steve G wrote:
> Hi,
> 
> I was testing the new policy writing GUI in rawhide, and removed a
> policy module. Prelink ran while I was working on a better policy
> module and gave me a bunch of AVCs since the binaries are now
> considered unlabeled_t. I was thinking that semodule should be able to
> get to the file regexes that describes the files that the policy
> module was responsible for. So why doesn't it save those regexes and
> use them to do a restorecon after the module is removed? It might not
> get all the files that are mislabeled due to the policy module being
> removed, but it would be much better than doing nothing.

Well, at present, semodule / libsemanage never causes anything to be
relabeled automatically - you install a policy module via semodule -i
and then install or restorecon the files, you add local file contexts
via semanage and then install or restorecon the files, etc.  So what you
seem to be after is fully integrated policy changes with relabeling,
including not only module removal but also module install, local file
context addition or removal, etc.

Ideally of course the files would be relabeled or removed _before_ the
policy module was fully removed, so that they never exist in an
unlabeled state at all.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
