Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0MHmnDr008412
 for <selinux@tycho.nsa.gov>; Thu, 22 Jan 2015 12:48:49 -0500
Received: by mail-ob0-f172.google.com with SMTP id wp18so2801253obc.3
 for <selinux@tycho.nsa.gov>; Thu, 22 Jan 2015 09:48:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150122085150.GB1268@kroah.com>
References: <1421855650-22522-1-git-send-email-sds@tycho.nsa.gov>
 <20150122085150.GB1268@kroah.com>
Date: Thu, 22 Jan 2015 09:48:47 -0800
Message-ID: <CAFJ0LnGzSoVxPrVhVhY5dD-zcoT74TquZd0A1WxQCin7LqQyPA@mail.gmail.com>
Subject: Re: [PATCH] Add security hooks to binder and implement the hooks for
 SELinux.
From: Nick Kralevich <nnk@google.com>
To: Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
 lkml <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org,
 SELinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Acked-By: Nick Kralevich <nnk@google.com>

On Thu, Jan 22, 2015 at 12:51 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Jan 21, 2015 at 10:54:10AM -0500, Stephen Smalley wrote:
>> Add security hooks to the binder and implement the hooks for SELinux.
>> The security hooks enable security modules such as SELinux to implement
>> controls over binder IPC.  The security hooks include support for
>> controlling what process can become the binder context manager
>> (binder_set_context_mgr), controlling the ability of a process
>> to invoke a binder transaction/IPC to another process (binder_transaction),
>> controlling the ability of a process to transfer a binder reference to
>> another process (binder_transfer_binder), and controlling the ability
>> of a process to transfer an open file to another process (binder_transfer_file).
>>
>> These hooks have been included in the Android kernel trees since Android 4.3.
>
> Very interesting, I missed the fact that these were added in that tree,
> thanks for digging it out and submitting it.
>
> I'd like some acks from some Android developers before I take these.
> Or, if it's easier for them to go through the security tree, that's fine
> with me as well.
>
> thanks,
>
> greg k-h



-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
