Message-ID: <44577454.5040204@gentoo.org>
Date: Tue, 02 May 2006 11:01:40 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        Paul Nasrat <pnasrat@redhat.com>, Jeremy Katz <katzj@redhat.com>,
        James Antill <jantill@redhat.com>
Subject: Re: We are attempting once again to split policy out into individual
 RPMS.
References: <44576B91.8060607@redhat.com>
In-Reply-To: <44576B91.8060607@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> I had more meetings with the install and RPM team at Red Hat about 
> splitting out policy into individual packages for RHEL5/FC6.  We had 
> many discussions about possible ways of doing this including breaking 
> out policy into separate packages, ie http_policy.rpm but this was 
> discounted as it was seen as a policy explosion.  Also
How is it a policy explosion? What does that mean exactly?

> we discussed only doing the semodule as the last in the transaction 
> but this ability is being de-emphasized in the installer, so it was 
> thought to keep it simple and install the policy within each RPM that 
> ships with policy, sort of the ldconfig model.
>
de-emphasized by the installer?  Not sure I follow, rebuilding the 
policy every time is expensive and may get worse (policy server 
enforcement).

> We need the ability for RPM to be able to write a file context on disk 
> without the kernel verifying it.  The kernel should treat this as an 
> unlabeled_t file. the same way it would if I ran
>
> semodule -i XYZ.pp
> restorecon /usr/bin/XYZ
> semoduel -e XYZ
>
> I don't think this is an unreasonable request to allow rpm_t to have 
> the privilege of writing the "invalid" context to disk.
>
hrm, there was a previous conversation about this, which I can't find in 
the archives for some reason. I'm at a loss as to why this needs to be 
done. The policy package should be installed before the application and 
the labels will become valid before they are used to install/label the 
package files.
> Secondly the rpm team would like to be able to execute the equivalent 
> of matchpathcon(XYZ.pp)  IE be able to extract the FC file mapping 
> from the policy package and combine it with the on disk representation 
> to determine the file context to associate with the new files being 
> put on disk.
>
hrm, this is unreliable unless you are combining file contexts from all 
possible modules being installed. Any given RPM transaction can easily 
have multiple policy packages and this needs to be addressed.
> At the end of the rpm install, postinstall would do an semodule -i 
> XYZ.pp.
The ideal order is to install all the policy packages first (shouldn't 
be too hard to move them to the beginning of the ordered list) and after 
they are installed do a single transaction to install them all (you have 
to do something like this regardless due to mutual dependencies) and 
then proceed to regular packages. This seems much cleaner than the sort 
of hackery being described here.
>
> We want to start out with just a couple of packages shipping policy to 
> prove the technology and then to allow third parties to ship using 
> this method.
This is a good thing.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
