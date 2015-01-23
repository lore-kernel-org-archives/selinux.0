Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0NLv3xY000681
 for <selinux@tycho.nsa.gov>; Fri, 23 Jan 2015 16:59:28 -0500
Message-ID: <54C2C38C.2000207@schaufler-ca.com>
Date: Fri, 23 Jan 2015 13:56:28 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
 Stephen Smalley <stephen.smalley@gmail.com>
Subject: Re: [PATCH] Add security hooks to binder and implement the hooks
 for SELinux.
References: <1421855650-22522-1-git-send-email-sds@tycho.nsa.gov>
 <20150122085150.GB1268@kroah.com> <54C13CBC.3050004@schaufler-ca.com>
 <CAB9W1A3B1e8X+VoFb+CNqUo=mH3eK1AdJjU2D7DvWjFdsywWgA@mail.gmail.com>
 <20150123023045.GA17138@kroah.com>
In-Reply-To: <20150123023045.GA17138@kroah.com>
Content-Type: text/plain; charset=windows-1252
Cc: linux-security-module@vger.kernel.org,
 Linux Kernel <linux-kernel@vger.kernel.org>, arve@android.com,
 selinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 1/22/2015 6:30 PM, Greg KH wrote:
> On Thu, Jan 22, 2015 at 01:47:29PM -0500, Stephen Smalley wrote:
>> On Thu, Jan 22, 2015 at 1:09 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 1/22/2015 12:51 AM, Greg KH wrote:
>>>> On Wed, Jan 21, 2015 at 10:54:10AM -0500, Stephen Smalley wrote:
>>>>> Add security hooks to the binder and implement the hooks for SELinux.
>>>>> The security hooks enable security modules such as SELinux to implement
>>>>> controls over binder IPC.  The security hooks include support for
>>>>> controlling what process can become the binder context manager
>>>>> (binder_set_context_mgr), controlling the ability of a process
>>>>> to invoke a binder transaction/IPC to another process (binder_transaction),
>>>>> controlling the ability of a process to transfer a binder reference to
>>>>> another process (binder_transfer_binder), and controlling the ability
>>>>> of a process to transfer an open file to another process (binder_transfer_file).
>>>>>
>>>>> These hooks have been included in the Android kernel trees since Android 4.3.
>>>> Very interesting, I missed the fact that these were added in that tree,
>>>> thanks for digging it out and submitting it.
>>>>
>>>> I'd like some acks from some Android developers before I take these.
>>>> Or, if it's easier for them to go through the security tree, that's fine
>>>> with me as well.
>>> My only concern is that we're about to see a set of hooks proposed
>>> for kdbus as well, and it would be a shame if we had two sets of hooks
>>> that do roughly the same thing (ok, *very roughly*) introduced back to back.
>> Not sure how much commonality there truly is among them (based on the
>> last set of proposed kdbus lsm hooks that I saw, admittedly a while
>> ago) and modules may want to distinguish between the two
>> forms of IPC regardless.  The binder hooks have been in place in the
>> Android kernel trees for quite some time, so this patch is just making
>> the mainline binder driver consistent with what is already in Android.
>> If it turns out that there is significant duplication when the kdbus
>> lsm hooks land, I'd be happy to help coalesce them.
> Yeah, I would wait and see what happens with how the kdbus hooks look
> before worrying about this all that much.  As people are using the
> binder hooks today, and binder is in the kernel tree, but kdbus isn't,
> let's not worry about kdbus until that is merged.

That seems like a sane plan to me in light of the situation. I am somewhat
concerned about the growth in special case security behavior. The tun hooks,
now the binder hooks and later the kdbus hooks. It looks like we're going
in the direction of special policies for each kind of communication rather
than a system IPC policy. On the other hand, that appears to be the trend in
system security overall, so even I can see that it may be prudent.


>
> thanks,
>
> greg k-h
>
