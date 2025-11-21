Received: from mail.redfish-solutions.com (mail.redfish-solutions.com [24.116.100.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF3F2D1932
	for <selinux@vger.kernel.org>; Fri, 21 Nov 2025 02:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.116.100.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763693294; cv=none; b=jv/FFmTp4T1iWcSLzSSaKPU0z7W6zBIapJaOmciQ8rPU8OiDAQmwmqd/55uNlCm/XhR56O0HHgz1d4pzG+qpXVTM3+4eryWL5RSJsISFtegQFlSGmMtEZbXGRfqo7++u5C3IkxLmbONdel8md8nR9s3jp1zcuQvjfB7Ou0KuJRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763693294; c=relaxed/simple;
	bh=9nH7xVjcb/Jdhpvm5pjGS9DaGBJK1bJlhmuc6e5JNa0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PywjEBLR1UJy7XyXuBN7lmmgb9yfs/Ek6gk8NumWyu8HWBgf6D0cFZ/lOzi5nhiicxEZoby/0aUex/JOeuAWZnBiOeknBkhvHiuOXAonsdeLpofrzYvJ91Cg2V9M20k7IdiZbO7y6Sp1DD/RS30UEeYfvfkBectpK+tZCObMQeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=redfish-solutions.com; spf=pass smtp.mailfrom=redfish-solutions.com; arc=none smtp.client-ip=24.116.100.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=redfish-solutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redfish-solutions.com
Received: from smtpclient.apple ([192.168.8.9])
	(authenticated bits=0)
	by mail.redfish-solutions.com (8.18.1/8.18.1) with ESMTPSA id 5AL2mA3T102061
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 19:48:10 -0700
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.3\))
Subject: Re: Adding SElinux support for a service
From: Philip Prindeville <philipp_subx@redfish-solutions.com>
In-Reply-To: <CAEjxPJ7umghjAo3Yg25QsYL+pfQ27bxOvS8J2S5-MSKtKZBXww@mail.gmail.com>
Date: Thu, 20 Nov 2025 19:48:00 -0700
Cc: selinux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <60A8D560-3A88-48B7-88AE-1D7023AF2B44@redfish-solutions.com>
References: <D6E78BE1-7054-46F2-AA10-1BC2E0D4A82B@redfish-solutions.com>
 <CAEjxPJ7umghjAo3Yg25QsYL+pfQ27bxOvS8J2S5-MSKtKZBXww@mail.gmail.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.3)
X-Scanned-By: MIMEDefang 3.6 on 192.168.8.3



> On Nov 20, 2025, at 2:15=E2=80=AFPM, Stephen Smalley =
<stephen.smalley.work@gmail.com> wrote:
>=20
> On Thu, Nov 20, 2025 at 3:14=E2=80=AFPM Philip Prindeville
> <philipp_subx@redfish-solutions.com> wrote:
>>=20
>> Hi,
>>=20
>> I'm working on SElinux support for a server that talks to a PCIe GPS =
card.
>>=20
>> Is there a guide to how to port a new service to SElinux, for =
instance how to give it its own context?  Or, in the absence of a guide, =
what GitHub project can I look at for the supporting commits that were =
done to achieve the same?
>=20
> Can you elaborate a little on what it is you want to do? Do you have
> SELinux enabled and enforcing already on the base system and just want
> to add policy for a new service to confine it and/or control what
> other processes can talk to it?
> Or do you also want the service to be SELinux-aware, aka a userspace
> object manager, where it enforces its own security policy over its own
> objects and operations?
> What's your starting point?


Yes, I have an SElinux system (RHEL 10.0) and I=E2=80=99m running the =
daemon on it.  I want to package policy rules with the daemon, but yes, =
I also want to confine the daemon to its own context.

Currently only chronyd or ntpd would talk to it, either by the char =
device it creates, or else the shared memory segment it creates.


