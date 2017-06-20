Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5KLhsYB028463
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 17:43:55 -0400
Received: by mail-lf0-f65.google.com with SMTP id u62so17618555lfg.0
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 14:43:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497989063.12069.18.camel@tycho.nsa.gov>
References: <20170619213348.2970-1-aranea@aixah.de>
 <CAHC9VhQsVa+0LgqFyguqq0bhXOz7mrbJfXy-+rJjY53xnCkixg@mail.gmail.com>
 <1497989063.12069.18.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Jun 2017 17:43:38 -0400
Message-ID: <CAHC9VhTz2uFMAcYBCph1=XVtib1owCuSi+c1stQsxkymDt_BJQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: Assign proper class to PF_UNIX/SOCK_RAW sockets
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Luis Ressel <aranea@aixah.de>, James Morris <james.l.morris@oracle.com>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jun 20, 2017 at 4:04 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2017-06-20 at 15:49 -0400, Paul Moore wrote:
>> On Mon, Jun 19, 2017 at 5:33 PM, Luis Ressel <aranea@aixah.de> wrote:
>> > For PF_UNIX, SOCK_RAW is synonymous with SOCK_DGRAM (cf.
>> > net/unix/af_unix.c). This is a tad obscure, but libpcap uses it.
>> >
>> > Signed-off-by: Luis Ressel <aranea@aixah.de>
>> > Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>> > ---
>> >  security/selinux/hooks.c | 1 +
>> >  1 file changed, 1 insertion(+)
>>
>> My only concern is what effect this will have on existing policy.
>> Prior to this patch PF_UNIX/SOCK_RAW will result in the generic
>> "socket" class where after this patch it will result in the
>> "unix_dgram_socket".  I believe this is the right change, but it
>> seems
>> like this should be wrapped by a policy capability, yes?
>
> I doubt it is worth a policy capability.

Agreed that a policy capability is pretty heavy for something to have
little impact, I'm just trying to be a bit more consistent about these
things (reference the thread we had a few weeks ago).

> Permission to create/use
> socket tends to be far rarer than permission to create/use
> unix_dgram_socket; looks like we never allow the former without the
> latter in Fedora, for example.

Considering where we are at with respect to the merge window, let's
shelve this for now and I'll merge it after the next merge window
closes.  In all likelihood I'll be sending selinux/next up to James
later this week and I'd like this to sit in linux-next for longer than
a few days.

-- 
paul moore
www.paul-moore.com
