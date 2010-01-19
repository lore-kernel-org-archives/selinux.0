Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0J1icqB004275
	for <selinux@tycho.nsa.gov>; Mon, 18 Jan 2010 20:44:38 -0500
Received: from mail-gx0-f221.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o0J1h8k2024524
	for <selinux@tycho.nsa.gov>; Tue, 19 Jan 2010 01:43:08 GMT
Received: by gxk21 with SMTP id 21so2977366gxk.19
        for <selinux@tycho.nsa.gov>; Mon, 18 Jan 2010 17:44:29 -0800 (PST)
Message-ID: <4B550EB9.50806@gmail.com>
Date: Mon, 18 Jan 2010 17:45:29 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: TaurusHarry <harrytaurus2002@hotmail.com>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: Re: Bootup problem with refpolicy-2.20091117
References: <BAY111-W27B5C0DF57292CB495990DAB660@phx.gbl>,<4B53CEB9.3050207@gmail.com> <BAY111-W3E475DBD218D365CE90B6AB660@phx.gbl>,<4B543977.40007@gmail.com> <BAY111-W38C1EDA473E7D38CE32E9EAB650@phx.gbl>
In-Reply-To: <BAY111-W38C1EDA473E7D38CE32E9EAB650@phx.gbl>
Content-Type: text/plain; charset=GB2312
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/18/10 17:35, TaurusHarry wrote:
> HI Justin,
> 
> No, I have selinux=1 in the bootparam, and /etc/selinux/config set to 
> enforce.
> 
> Thanks,
> Harry
> 
> 
>  > Date: Mon, 18 Jan 2010 02:35:35 -0800
>  > From: justinmattock@gmail.com
>  > To: harrytaurus2002@hotmail.com
>  > CC: selinux@tycho.nsa.gov
>  > Subject: Re: Bootup problem with refpolicy-2.20091117
>  >
>  > o.k. so you have a bootparam as selinux=0,
>  > and /etc/selinux/config > set to permissive right?
>  >
>  >
>  > Justin P. Mattock
>  >
>  > --
>  > This message was distributed to subscribers of the selinux mailing list.
>  > If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
>  > the words "unsubscribe selinux" without quotes as the message.
> 
> ------------------------------------------------------------------------
> 更多热辣资讯尽在新版MSN首页！ 立刻访问！ <http://cn.msn.com/>

then that could be what your hitting.
(noticed this a while back over here for some reason or another);

try booting with both: (boot param)enforcing=0
and (/etc/selinux/config)SELINUX=permissive

and see if you boot up.. then define the rules.

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
