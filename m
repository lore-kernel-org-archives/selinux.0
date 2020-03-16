Return-Path: <SRS0=RXLG=5B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E10DC0044D
	for <selinux@archiver.kernel.org>; Mon, 16 Mar 2020 20:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A32B20674
	for <selinux@archiver.kernel.org>; Mon, 16 Mar 2020 20:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732520AbgCPUaX convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:30:23 -0400
Received: from [37.139.156.29] ([37.139.156.29]:19732 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1732516AbgCPUaX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Mar 2020 16:30:23 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2020 16:30:22 EDT
Subject: Re: Policy module to allow a domain transition
To:     Alan Stern <stern@rowland.harvard.edu>
References: <Pine.LNX.4.44L0.2003161146070.8175-100000@netrider.rowland.org>
From:   peter enderborg <peter.enderborg@sony.com>
CC:     <selinux@vger.kernel.org>
Message-ID: <c9b092e8-caa5-52dd-1efb-1a5ab324a68f@sony.com>
Date:   Mon, 16 Mar 2020 21:20:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.2003161146070.8175-100000@netrider.rowland.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Rffu9Glv c=1 sm=1 tr=0 a=Jtaq2Av1iV2Yg7i8w6AGMw==:117 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=SS2py6AdgQ4A:10 a=1d-GhT9I8uALa4Tgr6MA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/16/20 5:04 PM, Alan Stern wrote:
> If this is not the the right forum for this discussion, please redirect
> me to some place more appropriate.  Where to go for good advice on the
> trickier details of selinux is not obvious.
>
> The setting is CentOS 8.1.  I'm running tcpserver as a systemd service.  
> tcpserver is a general-purpose Internet (actually TCP) service 
> dispatcher, rather like inetd.
>
> In this case, I'm trying to use tcpserver as an entryway to sshd.  It 
> works fine when selinux is in permissive mode but fails in enforcing 
> mode.  According to audit.log, the error is:
>
> type=AVC msg=audit(1584123331.011:167): avc:  denied  { dyntransition } for  pid=2002 comm="sshd" scontext=system_u:system_r:unconfined_service_t:s0 tcontext=unconfined_u:unconfined_r:unconfined_t:s0 tclass=process permissive=1
>
> I take this to mean that tcpserver runs in the unconfined_service_t 
> domain (confirmed by ps -Z), that when it execs the sshd program it 
> doesn't make the transition to the sshd_t domain, and consequently sshd 
> is prevented from doing what it wants.
>
> audit2allow's recommendation is:
>
> 	allow unconfined_service_t unconfined_t:process dyntransition;
>
> which probably would work, but it seems like treating the symptom
> rather than the disease, not to mention opening up a fairly large
> security hole.  I'd like something a little more specific, particularly
> since I want to run one or two other services under tcpserver in
> addition to sshd.
>
> Probably the best approach would be to create a new tcpserver_t type
> with all the appropriate policies, but that's beyond my current skill.  
> Would it make sense to create a policy module that would simply allow
> unconfined_service_t to transition to sshd_t?
>
> And what would the source for such a policy module look like?  The 
> impression I get is something like:
>
> 	allow unconfined_service_t sshd_exec_t:file { execute
> 		execute_no_trans getattr ioctl map open read };
>
> basically just a copy an existing policy for inetd_t and 
> sshd_exec_t.  Is that the right way to go about this?  Is there 
> something better?

The hole idea with MAC is that you should explicit declare what is allowed.

Starting with anything unconfined is a bad idea for anything that is seen
from the internet. If you do it for the security your tcpserver should have it's own
domain that is not unconfined. And then you can give rules on what it is allowed
to start.  So you need to create a tcpservice_service_t, so your rule should be

allow tcpservice_service_t sshd_exec_t:file { execute
		execute_no_trans getattr ioctl map open read };

/* execute_no_trans is probably not what you want */

 But you do NOT want

allow tcpservice_service_t unconfined_t:process dyntransition;


On fedora it would be like:

allow tcpservice_service_t sshd_t:process dyntransition;

and sshd is then allowed to create unconfined shell or what ever.
 

> Thank you,
>
> Alan Stern
>
>

