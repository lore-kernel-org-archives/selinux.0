MIME-Version: 1.0
In-Reply-To: <4D6176AD.3000807@schaufler-ca.com>
References: <OFF4F848CC.EFE2D45E-ON8625783A.0076BBE7-8625783B.001141BA@us.ibm.com>
	<1298035684.23592.6.camel@moss-pluto>
	<OFEB82FE90.36E35458-ON8625783B.005690C6-8625783B.00594784@us.ibm.com>
	<1298046341.23592.16.camel@moss-pluto>
	<OFAB2AD310.C60A1CF4-ON8625783B.007027A3-8625783B.0071BDC6@us.ibm.com>
	<AANLkTimtVyT-7p+6H9=8KGE=cmHNr7kgramsdH5coWwv@mail.gmail.com>
	<AANLkTik76eqvav9NvFbKSacitH-aZ14vxUeDRc_JWYGY@mail.gmail.com>
	<4D6176AD.3000807@schaufler-ca.com>
Date: Mon, 21 Feb 2011 14:56:31 -0500
Message-ID: <AANLkTimE5_WdsVVp-LtTGYoUMGstW7H1poj8o6PdWow-@mail.gmail.com>
Subject: Re: inode security state and cluster file systems
From: Eric Paris <eparis@parisplace.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Yuri L Volobuev <volobuev@us.ibm.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux@tycho.nsa.gov, selinux@davequigley.com, swhiteho@redhat.com,
        Mark Fasheh <mfasheh@suse.com>, Joel Becker <jlbec@evilplan.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Feb 20, 2011 at 3:16 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 2/18/2011 2:40 PM, Eric Paris wrote:

>>> If we made the invalidation point an explicit refresh of the label at
>>> least the filesystems would be able to control both of those
>>> problems.....
>
> So far the only case that has been discussed is one in which there
> is one security attribute on the file. While we don't have it yet there
> are a couple of efforts underway to support multiple concurrent LSMs.
> It is also plausible for an LSM to use more than one security attribute
> on a given file. An approach based on a secid interface may not work
> in either scenario. If you want a comparative example, look at directory
> default ACLs, which are important security information, but are nor used
> to make access decisions on the object to which they are attached.

I'm still leaning towards a solution in which the filesystem needs to
tell the LSM that it's labels are invalid (I suggest that be done on
any change in the security.* namespace) and that same call needs to
cause the LSM to refresh its labels.  I seem to think that such a call
would work just fine with any LSM stacker or even
multi-attribute/multi-label LSM (which uses the security.* namespace).

The biggest problem is if the 3 cluster filesystems in question can
handle an interface that requires a dentry and if they can handle the
fact that we do permissions checks on read/write and would like those
operations to start failing immediately if another node changed the
label.  I really don't see any other way to solve the problem....

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
