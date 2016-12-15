Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBFNN7Ll002620
 for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2016 18:23:07 -0500
Received: by mail-wm0-f44.google.com with SMTP id g23so8500202wme.1
 for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2016 15:23:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1481839327.20082.14.camel@tycho.nsa.gov>
References: <1481318475-7288-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhQ_VpmLPuJOoE9OY0aawHW_=Ka_=+M3Yghao9HmjDnxMA@mail.gmail.com>
 <1481839327.20082.14.camel@tycho.nsa.gov>
From: Paul Moore <pmoore@redhat.com>
Date: Thu, 15 Dec 2016 18:23:04 -0500
Message-ID: <CAGH-KgutsirOv2O2-e4P+nmzR2Yq=-txjnrxikxPfYZR4dW63Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: clean up cred usage and simplify
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <paul@paul-moore.com>, dhowells@redhat.com,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Dec 15, 2016 at 5:02 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2016-12-15 at 16:10 -0500, Paul Moore wrote:
>> We should have a little more naming consistentcy between
>> current_has_system() and self_has_perm().  Something like
>> current_has_process/current_has_system,
>> self_has_process/self_has_system, or something else along the lines
>> ... I think you get the idea.
>
> Not sure how to improve upon it in a manner that is concise and clear.
> At present, the patch splits the old task_has_perm() into
> task_has_perm_to_current() vs self_has_perm() and renames
> task_has_system() to current_has_system().  If I rename self_has_perm()
> to current_has_process(), then it seems confusingly similar and
> inconsistent with the existing current_has_perm(), which is unchanged
> by this patch. If I instead rename current_has_system() to
> self_has_system(), then that also seems confusing/inconsistent;
> self_has_perm() indicates it is a current-self check, whereas
> current_has_system() is a current-kernel:system check.  I could do that
> but not sure it is an improvement.
>
> The other option would be to inline them all since they are all quite
> trivial now.

Perhaps this last option is best, as you point out, these are all
basically just one-liner wrappers at this point and offer little
standalone value.

-- 
paul moore
security @ redhat
