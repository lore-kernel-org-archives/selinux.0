Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sAKDrJZ5014432
 for <selinux@tycho.nsa.gov>; Thu, 20 Nov 2014 08:53:19 -0500
Message-ID: <546DF23A.2000300@tresys.com>
Date: Thu, 20 Nov 2014 08:52:58 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: <selinux@tycho.nsa.gov>
Subject: Re: [RFC] systemd the userspace object manager
References: <546B760D.8070407@tresys.com>
 <20141118192010.GA32498@e145.network2>
In-Reply-To: <20141118192010.GA32498@e145.network2>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/18/2014 2:20 PM, Dominick Grift wrote:
>>
>> class init_service
>> {
>>     start
>>     stop
>>     status
>> }
>>
> 
> I cannot really substantiate but it look like these are also used to start/stop/get status of systemd (session) daemons, so i suppose start_init, stop_init, get_status_init
> 
> I suspect this is mainly for starting the systemd session daemons. Logind uses these i believe.
> 
> so to start a systemd session daemon: allow ARG init_t:init start_init;  or something maybe?

Why would those daemons need to be treated specially?  In the end
they're still services; they may have special system features, but in
that case you don't allow just anyone to stop/start them.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
