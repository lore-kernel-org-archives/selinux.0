Message-ID: <1347375110.18749.2.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: mmac-4.1.1?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Tue, 11 Sep 2012 10:51:50 -0400
In-Reply-To: <504F43EF.4030900@manicmethod.com>
References: <504F43EF.4030900@manicmethod.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-09-11 at 10:00 -0400, Joshua Brindle wrote:
> I'm wondering if there are plans for an mmac-4.1.1 branch? I see 
> mmac-4.0.4 and mmac (which I assume tracks master). I'd like 
> install-time and revocation mmac in 4.1.1. Perhaps I'm missing a branch 
> that provides that?

We merged the install-time MAC support into our main seandroid branches
(i.e. seandroid, seandroid-4.0.4, and seandroid-4.1.1) back in July.
Since that time, mmac and mmac-4.0.4 haven't been maintained - they are
dead (and I don't think they even exist on bitbucket).

We did recently create revoke-perms-jb and tagprop-jb branches with
rebased versions of the revoke-perms and tagprop changes.  You should in
theory be able to cherry-pick changes from those branches onto
seandroid-4.1.1.  But we haven't been doing much with them of late.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
