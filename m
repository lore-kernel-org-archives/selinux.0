Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8PI4aKN015872
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 14:04:36 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <1443039368-55445-1-git-send-email-seth.forshee@canonical.com>
 <1443039368-55445-5-git-send-email-seth.forshee@canonical.com>
 <87fv23o4vs.fsf@x220.int.ebiederm.org>
 <20150925124924.GB104990@ubuntu-hedt>
Date: Fri, 25 Sep 2015 12:57:12 -0500
In-Reply-To: <20150925124924.GB104990@ubuntu-hedt> (Seth Forshee's message of
 "Fri, 25 Sep 2015 07:49:24 -0500")
Message-ID: <87k2reidqf.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v4 4/7] fs: Limit file caps to the user namespace of the
 super block
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Seth Forshee <seth.forshee@canonical.com> writes:

> On Thu, Sep 24, 2015 at 04:59:35PM -0500, Eric W. Biederman wrote:
>> Seth Forshee <seth.forshee@canonical.com> writes:
>> 
>> > Capability sets attached to files must be ignored except in the
>> > user namespaces where the mounter is privileged, i.e. s_user_ns
>> > and its descendants. Otherwise a vector exists for gaining
>> > privileges in namespaces where a user is not already privileged.
>> >
>> > Add a new helper function, in_user_ns(), to test whether a user
>> > namespace is the same as or a descendant of another namespace.
>> > Use this helper to determine whether a file's capability set
>> > should be applied to the caps constructed during exec.
>> 
>> No issues with this but given that we always pass current_user_ns()
>> we may want to simplify the users of in_user_ns by renaming it
>> current_in_user_ns() and hard codeing current_user_ns().
>
> Sure, if that's what you prefer then I'll change it.

I took your patch as is.  This is a suggestion for a possible
incremental improvement.

Eric
