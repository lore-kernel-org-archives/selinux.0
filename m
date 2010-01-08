MIME-Version: 1.0
In-Reply-To: <1262964484.13162.20.camel@moss-pluto.epoch.ncsc.mil>
References: <1261610760-4724-1-git-send-email-ccase@tresys.com>
	 <1261610760-4724-2-git-send-email-ccase@tresys.com>
	 <1261610760-4724-3-git-send-email-ccase@tresys.com>
	 <1261610760-4724-4-git-send-email-ccase@tresys.com>
	 <1261610760-4724-5-git-send-email-ccase@tresys.com>
	 <1262961058.13162.4.camel@moss-pluto.epoch.ncsc.mil>
	 <1262963276.11210.33.camel@localhost>
	 <1262964484.13162.20.camel@moss-pluto.epoch.ncsc.mil>
Date: Fri, 8 Jan 2010 13:25:50 -0500
Message-ID: <150846cc1001081025q78f3ce3akf9ea839e9f04e371@mail.gmail.com>
Subject: Re: [PATCH 04/13] libsemanage: split final files into
	/var/lib/selinux/tmp
From: Caleb Case <ccase@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: jwcart2@tycho.nsa.gov, selinux@tycho.nsa.gov, csellers@tresys.com,
        kmacmillan@tresys.com, jbrindle@tresys.com
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jan 8, 2010 at 10:28 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Fri, 2010-01-08 at 10:07 -0500, James Carter wrote:
>> On Fri, 2010-01-08 at 09:30 -0500, Stephen Smalley wrote:
>> > On Wed, 2009-12-23 at 18:25 -0500, Caleb Case wrote:
>> > > This patch moves the final files from inside
>> > > /var/lib/selinux/<store>/[active|previous|tmp] to
>> > > /var/lib/selinux/tmp/<store>. The move is done to facilitate using
>> > > source control management on the /var/lib/selinux/<store> directory. If
>> > > these files remain in /var/lib/selinux/<store> they will pose a size
>> > > problem if an SCM like git is used as we'd be storing lots of binary
>> > > diffs. We are suggesting making this change now, rather than later when
>> > > source policy, SCM, and CIL[1] support are available, to ease the
>> > > migration burden.
>> > >
>> > > These are the files that have been moved:
>> > >
>> > > /var/lib/selinux/<store>/active/...       /var/lib/selinux/tmp/<store>/...
>> > >
>> > > file_contexts                             contexts/files/file_contexts
>> > > file_contexts.homedirs                    contexts/files/file_contexts.homedirs
>> > > file_contexts.local                       contexts/files/file_contexts.local
>> > > netfilter_contexts                        contexts/netfilter_contexts
>> > > policy.kern                               policy/policy.<policyversion>
>> > > seusers.final                             seusers
>> > >
>> > > The layout of these files in /var/lib/selinux/tmp/<store> is designed to
>> > > mirror their locations in /etc/selinux/<store>. This should help clarify
>> > > the relationship between these final files and the files installed in
>> > > etc.
>> > >
>> > > One consequence of this move is that reverting to the previous policy
>> > > version requires a policy rebuild. Currently you can revert without
>> > > rebuilding.
>> >
>> > That seems a little worrisome to me, as a rebuild might fail, e.g. what
>> > happens if we abort a transaction due to a lack of disk space and then
>> > try to revert, requiring a rebuild, only to run out of space during the
>> > rebuild?
>> >
>> If the transaction is aborted then the policy hasn't actually been
>> changed, so I don't think that this example would be a problem.  It is
>> only after the transaction is complete that everything is written to the
>> final location.  Or am I missing something?
>>
>> It would be a problem only if changes were made to the policy, that
>> policy loaded, there were problems, and then the rebuild of the previous
>> policy fails.
>
> I'm unclear on what state things would be left in.  I'm also unclear on
> the implications of writing these files to a single tmp/ location rather
> than having separate copies in active/, previous/, and tmp/ - I don't
> want us to unwittingly clobber files or leave them in intermediate
> states (as happened with the earlier attempt to hard link files among
> active/, previous/ and tmp/).

If there is an error and the transaction is aborted (for any reason),
then the effect is that nothing has changed. /etc/selinux/<store>
remains untouched. If this happens there shouldn't be any need to
revert. Since the tmp/<store> is emptied and then populated with
copies of the files from /etc/selinux/<store> when a transaction is
started there shouldn't be any files around to clobber. After a
transaction ends (successful or not), then tmp/<store> is emptied so
we shouldn't leave any files around in intermediate states. Only on a
successful transaction do we copy the files from tmp/<store> to
/etc/selinux/<store>.

>
> I tried running the code but I seem to see these "final files" still
> under the individual <store> directories in /var/lib/selinux rather than
> under tmp/.

I'm looking into this. After this patch the final files should all be
moved to tmp/.

>
> --
> Stephen Smalley
> National Security Agency
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
