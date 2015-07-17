Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6HHEDMI010311
 for <selinux@tycho.nsa.gov>; Fri, 17 Jul 2015 13:14:13 -0400
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
To: Seth Forshee <seth.forshee@canonical.com>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <87615k7pyu.fsf@x220.int.ebiederm.org> <20150716135947.GC77715@ubuntu-hedt>
 <55A7C920.7090206@schaufler-ca.com> <20150716185750.GB51751@ubuntu-hedt>
 <55A8253E.3000407@schaufler-ca.com> <20150717132146.GA65566@ubuntu-hedt>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <55A937E1.8040605@schaufler-ca.com>
Date: Fri, 17 Jul 2015 10:14:09 -0700
MIME-Version: 1.0
In-Reply-To: <20150717132146.GA65566@ubuntu-hedt>
Content-Type: text/plain; charset=windows-1252
Cc: Serge Hallyn <serge.hallyn@canonical.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/17/2015 6:21 AM, Seth Forshee wrote:
> On Thu, Jul 16, 2015 at 02:42:22PM -0700, Casey Schaufler wrote:
>
> <snip>
>
>>> I welcome feedback about anything I've missed, but stating generally
>>> that you think I probably missed something isn't very helpful.
>> True enough. I hope I've explained myself above.
> Thanks, that definitely clarified where we were having a disconnect.
> Andy's done a fantastic job explaining how those concerns are addressed.
>
>>> The LSM issue is thornier than the rest of it though, which is why I
>>> specifically asked for review there in the cover letter. There's a lot
>>> of complexity and nuance, and I still don't have a grasp on all the
>>> subtleties. One such subtlety is the full impact of simply ignoring the
>>> security labels on disk (but I am still confused as to why this is
>>> different from filesystems which don't support xattrs at all).
>> If you can mount a filesystem such that the labels are ignored you
>> are effectively specifying that the Smack label on the files be 
>> determined by the defaulting rules. With CAP_MAC_ADMIN that's fine.
>> Without it, it's not.
>>
>>> I was unaware of Lukasz's patches until yesterday, and I will have a
>>> look at them. But since we don't have the LSM support for user
>>> namespaces yet, I don't see the problem with doing something safe for
>>> LSMs initially and evolving the LSM integration for user ns mounts along
>>> with the rest of the user ns integration.
>> Ignoring the security attributes is not safe!
> Understood. It's surely safe for each LSM to deny such mounts until it
> has a way to handle them safely though.
>
> I'm not trying to completely punt on the issue of security modules, just
> break this down into more manageable chunks. You've given good guidance
> for Smack (thanks very much for that), so I can plan to work on that
> soon.
>
>>> Your point is taken about my less-than-expert opinion about the other
>>> security modules. We should at minimum get acks from the maintainers of
>>> those modules that unprivileged mounts will not compromise MAC.
>> I am the Smack maintainer. Unprivileged mounts as you have
>> described them compromise MAC. They compromise DAC, too.
> It looks like Andy's more or less convinced you that DAC isn't
> (additionally?) compromised. And there's a plan for MAC, that the
> security module can deny mounts from user namespaces until it has a
> solution for allowing them safely.

I wouldn't say that Andy has me convinced on DAC. I would say that
he's taken me deeper into the details of namespaces than I feel
comfortable making arguments about. I don't know that he's right,
I just don't know how to argue that he isn't. Part of what bothers
me is the dependence on namespaces. If you could come up with a
mechanism that wasn't dependent on namespaces it would be much
easier for dinosaurs like me to comprehend.

As far as declaring that MAC and namespace owned mounts are
incompatible goes, I think that I said early on that wasn't
going to fly. Too much of the Linux population (Fedora, Android,
Tizen, ...) uses MAC for the feature to be considered ready
for general consumption without it. And no, I don't believe in
partial implementations. You wouldn't get away with putting this
in if it only worked on s370 processors.

>>> For Smack specifically, I believe my only concern was the SMACK64EXEC
>>> attribute, as all the other attributes only affected subjects' access to
>>> the files. So maybe it would be possible to simply ignore this attribute
>>> in unprivileged mounts and respect the others, even lacking more
>>> complete LSM support for user namespaces.
>> SMACK64EXEC is analogous to the setuid bit, but I would rather see
>> exec() of programs with this attribute refused that for it to be
>> blindly ignored.
> That's fine, it's your call.

I said it, but on reflection the current NOSETUID behavior is
as you described it, so I wouldn't change that.

>
> Thanks,
> Seth
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
