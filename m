Subject: Re: question about policydb_index_*
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1280774889.20788.1.camel@dhcp231-200.rdu.redhat.com>
References: <1280774889.20788.1.camel@dhcp231-200.rdu.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 03 Aug 2010 08:23:22 -0400
Message-ID: <1280838202.31604.2.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-08-02 at 14:48 -0400, Eric Paris wrote:
> Why do we have a separate policydb_index_classes() and
> policydb_index_others() ?  It looks to me like I should be able to merge
> them both into policydb_index_others().  Is there something I'm missing
> or a reason I shouldn't do that?

You don't really want to allow classes to mingle with others - who knows
what will result? ;)

No, there isn't any reason to not fold them together in the kernel.
They are separate due to their origins in the policy compiler toolchain
code, where they do get called at different times.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
