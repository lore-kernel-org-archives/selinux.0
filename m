Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RKEowv015758
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 16:14:50 -0400
Received: by qcsk26 with SMTP id k26so255150qcs.12
        for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 13:14:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1332862097.15547.15.camel@lenny>
References: <4F71D850.20203@redhat.com>
	<1332862097.15547.15.camel@lenny>
Date: Tue, 27 Mar 2012 16:14:49 -0400
Message-ID: <CACLa4pv98tYgOihbuMu=em_k86DCcNpaHE2YBGqJpG_-zXyofA@mail.gmail.com>
Subject: Re: [PATCH 27/73] libselinux: Enable many more gcc warnings for
From: Eric Paris <eparis@parisplace.org>
To: Colin Walters <walters@verbum.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, eparis@redhat.com,
        selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We lose part of the message Colin?

On Tue, Mar 27, 2012 at 11:28 AM, Colin Walters <walters@verbum.org> wrote:
> On Tue, 2012-03-27 at 11:10 -0400, Daniel J Walsh wrote:
>> This patch looks good to me. acked.
>
> It's kind of ugly to conflate warnings with the control options like
> -fasynchronous-unwind-tables -funit-at-a-time
>
> Maybe consider splitting them out?
>
> Incidentally from the gcc manual:
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
