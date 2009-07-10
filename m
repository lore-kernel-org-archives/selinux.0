Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6ALBb3i032101
	for <selinux@tycho.nsa.gov>; Fri, 10 Jul 2009 17:11:37 -0400
Received: from mail-fx0-f220.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n6ALCJxk011695
	for <selinux@tycho.nsa.gov>; Fri, 10 Jul 2009 21:12:19 GMT
Received: by fxm20 with SMTP id 20so1078389fxm.18
        for <selinux@tycho.nsa.gov>; Fri, 10 Jul 2009 14:11:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1247241489.30551.86.camel@moss-lions.epoch.ncsc.mil>
References: <C67BD5B0.A89C1%csellers@tresys.com>
	 <4A575664.4040805@manicmethod.com>
	 <1247241489.30551.86.camel@moss-lions.epoch.ncsc.mil>
Date: Fri, 10 Jul 2009 17:11:35 -0400
Message-ID: <a040ffdc0907101411s479dbce2h5d41656e3b6960d4@mail.gmail.com>
Subject: Re: [RFC] Install SELinux policies from rpm package header
From: max bianco <maximilianbianco@gmail.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jul 10, 2009 at 11:58 AM, James Carter<jwcart2@tycho.nsa.gov> wrote:
> On Fri, 2009-07-10 at 10:55 -0400, Joshua Brindle wrote:
>> Chad Sellers wrote:
>> > On 7/9/09 4:48 PM, "Daniel J Walsh"<dwalsh@redhat.com>  wrote:
>> > <snip>
>> >> A couple of other problems with including policy with each rpm.  How do you
>> >> handle different packaging.  MLS, Targeted, minimal.
>> >>
>> > That is a problem we'll have to solve, but I don't think it will be too
>> > difficult. We could easily provide an option to the %policy directive that
>> > could direct rpm to use a particular policy store.
>> >
>> >> If every package includes policy then we need to rely on the package
>> >> maintainer to write good secure policy.  You have to realize that the goal of
>> >> a package maintainer is to make the tool run, not necessarily to make sure it
>> >> is secure or that other componants of the OS integrate well.
>> >>
>> >> ftp sometimes need to read any file on the OS, so I will add
>> >> files_read_all(ftp_t)
>> >>
>> >> Now getting the few packages that ship their own policy to work better and the
>> >> selinux-policy package to work better would be great.
>> >>
>> > That's our initial goal. We want better infrastructure for the packages that
>> > exist today. Policy can transition into other application packages if and
>> > when it makes sense. If a package maintainer has no business touching
>> > policy, then they will not be forced to do so.
>> >
>> >> How about fixing things like semanage command
>> >>
>> >> semanage fcontext ....
>> >> semanage ports ....
>> >> restorecon ...
>> >>
>> >>
>> >> Removal of policy packages is a huge problem in that once a type is removed
>> >> you end up with mislabeled files that can not be indentified.
>> >>
>> > Agreed, and we've talked about some potential solutions to this problem that
>> > do not involve automatic relabeling. This is a likely next step for this
>> > work after the initial RPM integration.
>> >
>>
>> The more I think about this the less I like the idea of uninstalling policy.
>> Even if we retain the labels (eg., save the namespace, ditch the rules) the
>> files are inaccessible. Leaving the policy ensures that admins/backup
>> apps/whatever can do whatever they could do before with the files, even if the
>> associated app is gone.
>>
> The same potential problems exist whenever policy modules (specifically
> types) are removed.
>
> Policy packages would be different from the current usage in two ways:
> 1) Policy modules would be removed when their associated application is
> not installed, whereas currently policy modules are probably never
> removed.
> 2) The removal would be automatic and right away, whereas currently an
> admin could take other actions before manually removing the policy
> module.
>
> So policy packages would be more likely to expose the problems that
> currently exist.
>
>> >> You do not know where these files are and you need to relabel the entire
>> >> machine to make sure there are no longer any mislabeled files around.
>> >>
>> >> When you update policy you need to run a diff between the old file context and
>> >> the new and run a recusive restorecon on the diff.  fixfiles -C
>> >> PREVIOUS_FILECONTEXT relabel does this for you, but every rpm transaction that
>> >> does a policy modules update needs to run this at the completion of the
>> >> transaction.  As well as squirrel away the previous file context before the
>> >> transaction.
>> >
>> > Running fixfiles -C after any rpm transaction that modifies policy seems
>> > reasonable (as long as there's an option to disable this behavior for those
>> > that don't like automatic relabeling).
>> >
>>
>> Its alot worse than that. What about files on backup drives? Offline drives?
>> transient files that will get relabeled to something inappropriate? I'm not
>> confortable relabeling databases with potentially sensitive data to var_lib_t
>> because mysql was uninstalled.
>>
>
> The argument seems to be for removing the ability to remove modules.
> It would be the roach motel style of policy management.
>
 Personally I am glad that this is in the works, I have really been
wanting some more control over what policy is installed, really I'd
rather not install packages without a policy. Nobody wants to leave it
up to the user and I don't blame them but trying to do this without
bugging the user is just begging for trouble. I could see a menu under
Authorizations (on Fedora) like this :

SELinux Policy Management

1. Install only signed policy (by signed I mean it was either
developed by the maintainers of refpolicy or reviewed by someone on
the distributions security team to ensure least privilege)

2. Prompt user for action : install signed policy, install policy
included with package, let me install my own policy or just run in the
user context

3. Let the app run unconfined or in a permissive domain - good for
tools like kismet that are sometimes a pain the ass to use in
conjunction with SELinux

4. Run the app in a generic sandbox

5. Install all policy regardless of source (discouraged)

Maybe authorizations isn't the place but that leaves  install time,
not a problem for me but many users will just swear in annoyance.

As to the ability to remove modules and potentially cause problems
like the database example, well that's a pickle and no mistake. I
would say give the files a separate unique context(created on the fly
if possible) that is only accessible by root, providing appropriate
warnings to the user about what they are doing and how to get access
to their files, as root then they can relabel it as they see fit. Just
a few thoughts, thanks for all your hard work. I sleep slightly better
with SELinux in enforcing mode :^)

--

Want to make an omelet? Start breaking eggs!!


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
