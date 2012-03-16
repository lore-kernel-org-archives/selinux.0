Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2GEUb3h015935
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2012 10:30:37 -0400
Received: by ghbz13 with SMTP id z13so4795433ghb.12
        for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2012 07:30:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F634C6B.2090804@tresys.com>
References: <CAPweEDzK22daM9ue26tMZ_6HbrFwEZxTfVUXhea31GFO4x0=Qw@mail.gmail.com>
	<4F634C6B.2090804@tresys.com>
Date: Fri, 16 Mar 2012 14:30:36 +0000
Message-ID: <CAPweEDx6t_Pz098dmUXVJ66QP0PkJ5tj-f+xTzUrCLPgs=wsBw@mail.gmail.com>
Subject: Re: B2G
From: lkcl luke <luke.leighton@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Mar 16, 2012 at 2:21 PM, Christopher J. PeBenito
<cpebenito@tresys.com> wrote:
> On 03/16/12 01:46, lkcl luke wrote:
>> second: did that idea of dynamically allowing bits of binary-compiled
>> se-linux permissions ever get implemented?  last time i was on this
>> list (eek, 2004?), the whole SE/Linux precompiled blob was just that:
>> one huge humungous gelatinous blob that you couldn't mess with, not
>> without doing a tooootal recompile using the m4 macros.
>
> Yes, we do have modular policy now.  Right now they are compiled, but hopefully we'll eventually be able to set to text modules.  You compile .pp files that have some compiled policy and optional a .fc, and link them together into the policy.2x

 thanks christopher, this is really useful and valuable stuff which
will help in the evaluation process.

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
