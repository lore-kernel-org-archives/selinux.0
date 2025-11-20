Received: from mail.redfish-solutions.com (mail.redfish-solutions.com [24.116.100.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154F62FFDFC
	for <selinux@vger.kernel.org>; Thu, 20 Nov 2025 20:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.116.100.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763669636; cv=none; b=HZ9jcwDDDwHTedpzeVPx8HhQ+EV6obr4bRvHun1d4cz6MK4hRybInOeJSd2njo4hhgVuKob7UgqOnX9JzT/wAv3KEXV8Cnpjz7oy41jzeg7Y2tLUjivxcudpGNFHy7IXDF3bDvxsuCkrbzRp9wEPa8vfvl1gJNpqd6BdXHVKKN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763669636; c=relaxed/simple;
	bh=SrVgYBkZ4ES64e+S8xPxIcwG3lH/H1TvrgJFeCNr28s=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=FWJiB9bN2qccq8Zf/zVqvBa9esjqh7O42GZlyOncfRmPtSQq6rZ181XRgiF0nJB5N6OMpMyxZM3Hxgt9D7tHZKnr4QACAQdoXCLtYHMmseZlL/NSL5771jI1C9+IpehpSJiPXtQxGUVDQ+nWq4zkmKk3QhiP6y6Pl7z0QPVJ2TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=redfish-solutions.com; spf=pass smtp.mailfrom=redfish-solutions.com; arc=none smtp.client-ip=24.116.100.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=redfish-solutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redfish-solutions.com
Received: from smtpclient.apple ([192.168.6.56])
	(authenticated bits=0)
	by mail.redfish-solutions.com (8.18.1/8.18.1) with ESMTPSA id 5AKK46xh098078
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <selinux@vger.kernel.org>; Thu, 20 Nov 2025 13:04:06 -0700
From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.3\))
Subject: Adding SElinux support for a service
Message-Id: <D6E78BE1-7054-46F2-AA10-1BC2E0D4A82B@redfish-solutions.com>
Date: Thu, 20 Nov 2025 13:03:54 -0700
To: selinux@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.3)
X-Scanned-By: MIMEDefang 3.6 on 192.168.8.3

Hi,

I'm working on SElinux support for a server that talks to a PCIe GPS =
card.

Is there a guide to how to port a new service to SElinux, for instance =
how to give it its own context?  Or, in the absence of a guide, what =
GitHub project can I look at for the supporting commits that were done =
to achieve the same?

Thanks,

-Philip

