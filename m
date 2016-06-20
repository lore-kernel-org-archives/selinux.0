Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5KLUXdK011857
 for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2016 17:30:33 -0400
Received: by mail-ob0-f170.google.com with SMTP id mu6so1787892obc.3
 for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2016 14:30:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6359b965-b5df-6f13-c536-97b396084625@tycho.nsa.gov>
References: <1466420991-7209-1-git-send-email-plautrba@redhat.com>
 <6359b965-b5df-6f13-c536-97b396084625@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 20 Jun 2016 17:30:30 -0400
Message-ID: <CAHC9VhRks3p4d=x0Dia94JsVypncJ5bxmW62vv+KGHFcEHOy0w@mail.gmail.com>
Subject: Re: [PATCH] libselinux: add selinux_snapperd_contexts_path()
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jun 20, 2016 at 9:38 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 06/20/2016 07:09 AM, Petr Lautrbach wrote:
>> Snapper needs a way how to set a proper selinux context on btrfs
>> subvolumes originating in snapshot create command. Fs can't handle it on
>> its own so snapper will enforce .snapshots subvolume relabeling
>> according to a file returned by selinux_snapperd_contexts_path().
>>
>> The format of the file will be similar to other contexts file:
>>
>> snapperd_data = system_u:object_r:snapperd_data_t:s0
>>
>> Fixes:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1247530
>> https://bugzilla.redhat.com/show_bug.cgi?id=1247532
>
> Seems like there is a kernel bug here, if btrfs snapshots are being
> created in unlabeled_t initially?  I understand and agree that
> ultimately something in userspace will have to assign a specific label,
> but they shouldn't be defaulting to unlabeled_t.

It's been too long since I've looked at this, but from what I recall
the btrfs snapshots are a real mess from a SELinux perspective and
setting an initial label was not an easy thing to do.

-- 
paul moore
www.paul-moore.com
