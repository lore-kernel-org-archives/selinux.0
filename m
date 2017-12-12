Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vBCMPqKK009248
 for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2017 17:25:52 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC13.oob.disa.mil (Postfix) with SMTP id 3yxDtP3r8Wz25ssH
 for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2017 22:25:49 +0000 (UTC)
Received: from UPBD19PA14.eemsg.mil (unknown [192.168.18.14])
 by UPDCF3IC13.oob.disa.mil (Postfix) with ESMTP id 3yxDtP34ZSz25ssN
 for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2017 22:25:49 +0000 (UTC)
Received: by mail-lf0-f50.google.com with SMTP id 74so475191lfs.0
 for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2017 14:25:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171212215638.GH3532@localhost.localdomain>
References: <20171127193121.2666-1-richard_c_haines@btinternet.com>
 <20171212160800.GE3532@localhost.localdomain>
 <CAHC9VhR+WoO3UtdXLp+9mQ=c=avpEQ5-W8vTkEWfxXH1EkUS8A@mail.gmail.com>
 <20171212215638.GH3532@localhost.localdomain>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 Dec 2017 17:24:46 -0500
Message-ID: <CAHC9VhQ5iQsXum6NVkL-qdzu=bxVcaOscPjTSVufLzRbW_1_Pw@mail.gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov,
 netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, nhorman@tuxdriver.com,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 2/4] sctp: Add ip option support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Dec 12, 2017 at 4:56 PM, Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
> On Tue, Dec 12, 2017 at 04:33:03PM -0500, Paul Moore wrote:
>> On Tue, Dec 12, 2017 at 11:08 AM, Marcelo Ricardo Leitner
>> <marcelo.leitner@gmail.com> wrote:
>> > Hi Richard,
>> >
>> > On Mon, Nov 27, 2017 at 07:31:21PM +0000, Richard Haines wrote:
>> > ...
>> >> --- a/net/sctp/socket.c
>> >> +++ b/net/sctp/socket.c
>> >> @@ -3123,8 +3123,10 @@ static int sctp_setsockopt_maxseg(struct sock *sk, char __user *optval, unsigned
>> >>
>> >>       if (asoc) {
>> >>               if (val == 0) {
>> >> +                     struct sctp_af *af = sp->pf->af;
>> >>                       val = asoc->pathmtu;
>> >> -                     val -= sp->pf->af->net_header_len;
>> >> +                     val -= af->ip_options_len(asoc->base.sk);
>> >> +                     val -= af->net_header_len;
>> >>                       val -= sizeof(struct sctphdr) +
>> >>                                       sizeof(struct sctp_data_chunk);
>> >>               }
>> >
>> > Right below here there is a call to sctp_frag_point(). That function
>> > also needs this tweak.
>> >
>> > Yes, we should simplify all these calculations. I have a patch to use
>> > sctp_frag_point on where it is currently recalculating it on
>> > sctp_datamsg_from_user(), but probably should include other places as
>> > well.
>>
>> FYI: Richard let me know he is occupied with another project at the
>> moment and likely won't be able to do another respin until next week
>> at the earliest.
>
> Okay, thanks. I can do a follow-up patch if it helps.

I'll leave that up to you, I think your comments are pretty
straightforward and should be easy for Richard to incorporate, and
there is a lot to be said for including the fix in the original patch,
but if you would prefer to send a separate patch I think that's fine
too.

-- 
paul moore
www.paul-moore.com
