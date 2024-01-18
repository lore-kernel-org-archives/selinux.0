Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875E128E3A
	for <selinux@vger.kernel.org>; Thu, 18 Jan 2024 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705595222; cv=none; b=ENSgGTwh8j51qQh4NXkvNCaSr7O9PujD7lMjJhF/OwI949JxTCVUIJYKIYEAzw2hU7YgEg4eWZyHO25ugtk8FTI4a5KhUKTQsZ1X8+kNsRKntdMCsoqffiB8rUwcwF/mIluw11tZ0CxaSaM6Q7qYK6uX/79UnIadAU2IK1AHBQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705595222; c=relaxed/simple;
	bh=riWqVhGTX5lGswri4oMRXxfHVfJlZeeI5vSmjfrDISI=;
	h=Received:DKIM-Signature:Received:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:X-Google-Smtp-Source:X-Received:
	 MIME-Version:From:Date:Message-ID:Subject:To:Content-Type:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=fg0V1ZCmhSJN2lE+xabfCdje7ZG/t0FoVaCj7ths1aRD/qsbN91M0vLzE6sZKKGmcQQyyTkGSWLChxG4reM0vcrA6qwSQdn6zwwoggiCDcjRcKhO22xmgvg3JGrg8VTwem03CNVqlt7R3uDmvukP+eUpMZiycfNnTEfSaeMwz+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=VQr9Sthh; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="VQr9Sthh"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40IFjaon015465
	for <selinux@vger.kernel.org>; Thu, 18 Jan 2024 11:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=mime-version : from
 : date : message-id : subject : to : content-type; s=pps01;
 bh=BF3zkj4zjXcLB36coxXU2fCYgjZnVcphVYy2qOdSDQs=;
 b=VQr9SthhlD6frUTtcTJuFUokFmauam1NWy0vsEDiQp/6jQXorL5q2STHWUq/cX+1pKlm
 ujiH5U8hxrUOoV7dZOC7Hz0kAmCsQ+aBczIIw+x0F4Pz6spPGeXCeRtRg0S/vz9EeO9Q
 EL7RcPxfATZCUSOJkoSv4CboxMRC8Wgcw8x9onOIJy9CpukTMHk4VYzecD2NnFJf60Sv
 OAec8EL4wJhdl96kTyh8DDPhPWh8LxZrLjh0vl9ynK1rB1oxKxJN8Hbp1atwDMx9VbRU
 RzVcrkjdY+p8ccRlpy859AH/8n/LFXT5vCmf5m4Az9gO27Q9e4m97iWqW9wq64vzPu43 4A== 
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 3vknp39nke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <selinux@vger.kernel.org>; Thu, 18 Jan 2024 11:26:59 -0500
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-203014900a9so15944141fac.3
        for <selinux@vger.kernel.org>; Thu, 18 Jan 2024 08:26:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705595218; x=1706200018;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BF3zkj4zjXcLB36coxXU2fCYgjZnVcphVYy2qOdSDQs=;
        b=AM5DhaQDARqUFPvE4yU+b6HqHOaIK6EXuMsElnq3hfHWXotEthooBcrEmpRgBsUNgo
         wEBFKOy0e6nHL2cpQgemM96GwKkC1AHPRey9dhoWOfcsZQ25gsknFTi9eCdkT0YQD83k
         MF7qAd9KGzkKbFJXhPRwdBiC4dGZjcYdawytwICz6h+s9vAUs3DmaJ1Al3lOuqr2Niuz
         06fll7bf3DilJWiMMZExotukpwpTus12JHXR7D1V2Ges9RrZoGqpSNyoP1+i++NGpy6B
         UKMtwPsbrGZzWIBVQoLcUwgIrhJNoTCAcDGJLyAQjDkv5FhDdwYBKRwcLCtBM3V5soEJ
         oyzA==
X-Gm-Message-State: AOJu0Ywi67TzJ2rP1B/U9aeUGx+isk3cRvR2HGvuiEbBpJwsOzdZRY4M
	tiKLaOgaTPdS7soqBs5eB7hpda+U2pCbrbRNBTkOa3yDKRMJJQMO2Mk0HXgy3UnwgJh1N3cQTaX
	QCQYnphxoDDrJ0wvVrtv/Z4aJ6D8YFnK4edWpuKKPXAfJvut/SHgHA6FIRWgInNFqE5iyvfn/sY
	kASbaPnw9oPeC4o9+mSwh2f2CbmqpkY42QpkKl
X-Received: by 2002:a05:6871:7a12:b0:210:9b48:d0c2 with SMTP id pc18-20020a0568717a1200b002109b48d0c2mr1024467oac.68.1705595218412;
        Thu, 18 Jan 2024 08:26:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEM1pnNiTE2QTyhvuVvcAQ0lD1rMXrV7PEvB29CKBpLRhyjFO39iDBcVnLdK1iCqWDvljQLo2Qc2KY6YN9H538=
X-Received: by 2002:a05:6871:7a12:b0:210:9b48:d0c2 with SMTP id
 pc18-20020a0568717a1200b002109b48d0c2mr1024459oac.68.1705595218193; Thu, 18
 Jan 2024 08:26:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gabriel Ryan <gabe@cs.columbia.edu>
Date: Thu, 18 Jan 2024 11:26:48 -0500
Message-ID: <CALbthtcf4m5vPK7xLZhzk8W_7ETkNPeR3bnaM06BtzuQy8w-jQ@mail.gmail.com>
Subject: Race in security/selinux/hooks.c on isec->sclass and isec->sid usage
To: Paul Moore <paul@paul-moore.com>, stephen.smalley.work@gmail.com,
        omosnace@redhat.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: -1SbBWqTlXMd72i73VJWyo96QF7vfMAG
X-Proofpoint-GUID: -1SbBWqTlXMd72i73VJWyo96QF7vfMAG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=10
 bulkscore=10 suspectscore=0 phishscore=0 mlxscore=0 clxscore=1011
 mlxlogscore=785 priorityscore=1501 lowpriorityscore=10 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401180120

We found a race in selinux for kernel v6.6 using a prototype race
testing tool based on modified KCSAN we are developing. We are
reporting the race because it appears to be a potential bug. The race
occurs on isec->sclass and isec->sid, which are set in

security/selinux/hooks.c:3329-3330 selinux_inode_post_setxattr

        isec->sclass = inode_mode_to_security_class(inode->i_mode);
        isec->sid = newsid;

Where isec->lock is held when isec->sclass and isec->sid are set above
but not held when they are read in the following 3 locations:

security/selinux/hooks.c:1671 inode_has_perm
security/selinux/hooks.c:3125 selinux_inode_permission
security/selinux/hooks.c:3690 ioctl_has_perm


This seems like it could lead to undefined behavior if multiple
threads are reading the isec struct and updating it concurrently,
(e.g., reading an old isec->sid value but new isec->sclass value).

In some other cases in security/selinux/hooks.c, isec->lock is held
when isec->sclass and isec->sid are accessed, such as in
security/selinux/hooks.c:4942-4945 selinux_socket_accept. Therefore,
extending the isec->lock to cover when sclass and sid are read from
the isec struct in these three locations might be a suitable fix.

Best,
Gabe
