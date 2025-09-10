Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BC1307482;
	Wed, 10 Sep 2025 23:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757545948; cv=none; b=Pg8hlVr5P7N8MvrGQlcR8pwsnQS3XECE0L2/xd5UlVNyBeVMiFaXs+mRSuYoett5vFmmrQULLlDyeqi1XbYtnpohzDHD2qdV9G37O3U0awYtS/30lI3G91Lp+9oZPSDopyjsWGrUOe3ahhHQecfk50ROsGz3Jovnaw10KY6jbJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757545948; c=relaxed/simple;
	bh=n4wDrOJ4+8oFO0FiTxRck8gYC+w4YduRB2nz7ydN4nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKIsxjzzc7G8dlJ/VkS4YRP23QujN2GIBtN0cBSq8nlonllsmX4w7cVi0TZJgGcafftawNKhrliB9Y1kVAWtlnDqEQQg51Op2aqdHMLQFNjD1ufCyF6rPsf2VoRbKluVVpb2mkIP52C5CbOB2PsTNo7TX+uXQkwiLqB9HVHRrIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=S1WX82rf; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="S1WX82rf"
Received: from pps.filterd (m0355089.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AK6HoS028264;
	Wed, 10 Sep 2025 23:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=GXNaxpXDaecg9dpDLtfpg+r
	/GJho9RVlZ4wvwX45vgc=; b=S1WX82rfW4pJyOqg3v75OrJyQCYGx39H1oajtFx
	bj2+KOjp03MU+HDvIK/kfhhFL2YjTjoGdwmyhA8/dRYDQ9lRgPsTaPqT6R9kVrzJ
	KJwEQBk0OQsIhqSBtBXNhN/9mXlVaEwesV2Bqt0youupLVzTSbI1pGXXPVNo5QPw
	uQdWU67M4OqNYqEyfSHoQHm7mZWnimUpRKphqM5cVL3thLpWuePtsXG/O3n+f3O8
	tN95MpvpAuJGevgZ6von5jNJFxkow2wJT/40uAk8cEQ7uuiFSTmbwMMfCwbLp7f6
	l5kqVLiTBsi7mfW6d2WGGiKojufUeJpszq7Mll3ebIBEozA==
Received: from iadlppfpol1.lenovo.com ([104.232.228.80])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 4911gntc5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 23:12:10 +0000 (GMT)
Received: from va32lmmrp01.lenovo.com (unknown [10.62.177.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by iadlppfpol1.lenovo.com (Postfix) with ESMTPS id 4cMbzy5xTcz8fkFk;
	Wed, 10 Sep 2025 23:11:58 +0000 (UTC)
Received: from ilclbld243.mot.com (ilclbld243.mot.com [100.64.22.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland@motorola.com)
	by va32lmmrp01.lenovo.com (Postfix) with ESMTPSA id 4cMc0B2ZPPz2VZ2P;
	Wed, 10 Sep 2025 23:12:10 +0000 (UTC)
Date: Wed, 10 Sep 2025 18:12:05 -0500
From: Maxwell Bland <mbland@motorola.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com,
        netdev@vger.kernel.org, horms@kernel.org
Subject: Re: [PATCH v7 01/42] selinux: restore passing of selinux_state
Message-ID: <6cfe4uqtic6ga3ch463zflke2wp5hobd7j3r5ctyp4puwbjiet@xgi6jfi7au3c>
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
 <20250814132637.1659-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814132637.1659-2-stephen.smalley.work@gmail.com>
X-Proofpoint-ORIG-GUID: Rk-9LfFivE9bjSa7rOblwI5ZwUx0Iwa6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA3MDAyNSBTYWx0ZWRfXwcL4ZLpVtQYJ
 75dNL7n24GUcUHHLVEXdiak9vtn4EfNO4CJzE2zqsJrW+iFZAJLlu/yRIOMeoNslBof3BLSdI3j
 oVATMio3vaMdYsJQ7pOCq78+FIL/8YQD0EoyHwnA+DevcuIZzMvHlT3lFbn8vCGPoPUYpjh0N7V
 eIHsflLngxANIcLrCDgFS0ysfjcOVhmdwQcyqbcM2ylbUyIKI5BwVOzqPORJwMCSHnxF26ba6Ta
 TEOWAIOF8ZVeVZzeWmoFrknsSf4JL3mbIjCVciOGgqLEtBAIZmPQh8bduiJO2UZduxjonpas2aB
 sSywaptmkfv8zpKBm+Ulhpgdp9nI0WR5vQ/wINzYlsR/tWqyq18sPEUYd5H2K0AMiHzFDOI2z0B
 P9nVZlHS
X-Authority-Analysis: v=2.4 cv=bopMBFai c=1 sm=1 tr=0 ts=68c205cb cx=c_pps
 a=LMRlKrtnqgVLeY6h3uZyow==:117 a=LMRlKrtnqgVLeY6h3uZyow==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=45E8AWlfMGMlSf_upCYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Rk-9LfFivE9bjSa7rOblwI5ZwUx0Iwa6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509070025

On Thu, Aug 14, 2025 at 09:25:52AM -0400, Stephen Smalley wrote:
> This reverts commit e67b79850fcc4eb5 ("selinux: stop passing selinux_state
> pointers and their offspring"). This change is necessary in order to
> support SELinux namespaces.
> 

FYI, thank you for this new commit. Some "fuel for the fire":

Turns out, e67b79850fcc4eb5 makes it hard to enforce immutability on the
SELinux state / AVC cache from EL2, because the compiler likes to put
them on the same page, leading to having the hypervisor track spinlock
management issues, just to ensure the core selinux state remains
unmodified. 

In the past (pre-2023/e67b79850fcc4eb5), it was possible to set the avc
cache onto a separate page from the other critical selinux_state data
during early boot, and it looks like this *may* restore that.

As you likely know, the issue is without EL2 enforcement of immutability
on the selinux_state page it is possible to just flip the enforcing bit
via EL1 write-gadget. It may also be possible to address this whole
issue using ARM MTE or something else.

Regards,
Maxwell Bland
