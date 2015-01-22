Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0MI94EP010296
 for <selinux@tycho.nsa.gov>; Thu, 22 Jan 2015 13:09:05 -0500
Message-ID: <54C13CBC.3050004@schaufler-ca.com>
Date: Thu, 22 Jan 2015 10:09:00 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] Add security hooks to binder and implement the hooks
 for SELinux.
References: <1421855650-22522-1-git-send-email-sds@tycho.nsa.gov>
 <20150122085150.GB1268@kroah.com>
In-Reply-To: <20150122085150.GB1268@kroah.com>
Content-Type: text/plain; charset=windows-1252
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 arve@android.com, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 1/22/2015 12:51 AM, Greg KH wrote:
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
> Very interesting, I missed the fact that these were added in that tree,
> thanks for digging it out and submitting it.
>
> I'd like some acks from some Android developers before I take these.
> Or, if it's easier for them to go through the security tree, that's fine
> with me as well.

My only concern is that we're about to see a set of hooks proposed
for kdbus as well, and it would be a shame if we had two sets of hooks
that do roughly the same thing (ok, *very roughly*) introduced back to back.

>
> thanks,
>
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
