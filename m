Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vBCLY9GD011391
 for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2017 16:34:09 -0500
Received: by mail-lf0-f43.google.com with SMTP id j124so337538lfg.2
 for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2017 13:34:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171212160800.GE3532@localhost.localdomain>
References: <20171127193121.2666-1-richard_c_haines@btinternet.com>
 <20171212160800.GE3532@localhost.localdomain>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 Dec 2017 16:33:03 -0500
Message-ID: <CAHC9VhR+WoO3UtdXLp+9mQ=c=avpEQ5-W8vTkEWfxXH1EkUS8A@mail.gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, nhorman@tuxdriver.com,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 2/4] sctp: Add ip option support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Dec 12, 2017 at 11:08 AM, Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
> Hi Richard,
>
> On Mon, Nov 27, 2017 at 07:31:21PM +0000, Richard Haines wrote:
> ...
>> --- a/net/sctp/socket.c
>> +++ b/net/sctp/socket.c
>> @@ -3123,8 +3123,10 @@ static int sctp_setsockopt_maxseg(struct sock *sk, char __user *optval, unsigned
>>
>>       if (asoc) {
>>               if (val == 0) {
>> +                     struct sctp_af *af = sp->pf->af;
>>                       val = asoc->pathmtu;
>> -                     val -= sp->pf->af->net_header_len;
>> +                     val -= af->ip_options_len(asoc->base.sk);
>> +                     val -= af->net_header_len;
>>                       val -= sizeof(struct sctphdr) +
>>                                       sizeof(struct sctp_data_chunk);
>>               }
>
> Right below here there is a call to sctp_frag_point(). That function
> also needs this tweak.
>
> Yes, we should simplify all these calculations. I have a patch to use
> sctp_frag_point on where it is currently recalculating it on
> sctp_datamsg_from_user(), but probably should include other places as
> well.

FYI: Richard let me know he is occupied with another project at the
moment and likely won't be able to do another respin until next week
at the earliest.

-- 
paul moore
www.paul-moore.com
