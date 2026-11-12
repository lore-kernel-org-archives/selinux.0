Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473841;
	b=nN1OpGnbIMX4J7OTfiXv+oS5vk7uqTCwnYhPxQKSKk2IHdHA8pLzem1W14vX0Yr4PkAu
	 E08RF53XRsa4mGdEhs3latcuLoIsSM2ofB5fsINwGQnnXyAM0Yerwv9uFJKZKGrfqu3Jb
	 qIXybp49Twe0eHU5eJxzfUrHdZy5wbkvnlSBnKfd+YWDBfHWNRVs3Lv8W2tGM6HX4iofY
	 2OtdB4zkerjn4zhnl+Mg9abGMrM2nwcGrslj3ClIstTh24KpmXnVrb4/0OJQ23PqCMVLu
	 bPdxQc21lfN7QA8nnQTE8on+PuI7LlchnxrGwtiftqJxudi0ihnH1TmBZp3yPyZUesw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473841;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=+IM6c9SQzhSiNLCPJKNescY2jVpZ6DadiC6JkBUJ1jI=;
	b=gxE3gEs00pD4J7lCNOJ6GnCMjLri3cTkQcIC+agpqJyQ5evu4Nuxhh46OwepfyBiewXE
	 1C+lZITFqlmh2m1RS1H0gdiLXjz2Agk1dRtubU+rWtzWtiv4GhlbHlwJPsEVeh7RFWDUC
	 aTg1VKeRHOONKosyvMMQXX5+nmSUrvOz+u4ndxDFAEbZB3Zvjzj5ui1Je964KjYNMY/6E
	 LBsCxXI23DENzcrZ4BgSe+WNKshiPXAOKR+R+pY4xe/EcUXRw8i6naXjcbko0n37zmJac
	 EeWY5VO+CBrpaBhv5DehBoJpi/nXMdIUIZDH6496yMwmzAEzamjoT9yVLOVaFuzrvlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UV65ZWDb;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mv8232rI;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4D3606A8AD
	for <selinux@vger.kernel.org>; Thu, 12 Nov 2026 08:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD4D3606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UV65ZWDb;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mv8232rI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794473839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+IM6c9SQzhSiNLCPJKNescY2jVpZ6DadiC6JkBUJ1jI=;
	b=UV65ZWDb83EtQFm4jjDLNA2FjEtDDkiZsUcHh/fiIE086uIlVerrneT8fgBRxZku0o5i57
	cdzQNLkcoQS2O9Q7uF4HOx4QDoQlVjcM1GcViSlcgvK+wvFi6rLZW38WR10WVM5Ifb2WU4
	4qVwbOlQOPE2kI1OoYJqVZnksBp4Cn8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-t2-2qFHCOnCpDpq0NG4eUw-1; Thu, 12 Nov 2026 03:57:17 -0500
X-MC-Unique: t2-2qFHCOnCpDpq0NG4eUw-1
X-Mimecast-MFC-AGG-ID: t2-2qFHCOnCpDpq0NG4eUw_1794473836
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so31100315e9.3
        for <selinux@vger.kernel.org>; Thu, 12 Nov 2026 00:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794473836; x=1795078636; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+IM6c9SQzhSiNLCPJKNescY2jVpZ6DadiC6JkBUJ1jI=;
        b=mv8232rIvwU2dAjk3wXAnXSS+uMGbkacq/op+xonRYuC6k/ZhbIk0tV5bEN5ivZ2mU
         xOrAP6wkhfvzc0qX7/Lp4uxWi7lv4e7IPbMJbXra5AryJBFmyHbpgNzrsIbxgLQcj/av
         8rZNiGz98kAn7W7U3jWE4ThS8GKIEG5rkBxmGz54oLr0AAKaHJH5HIoaA3rZNi32CbC6
         DJYA6W2e0xSo4mpsMevtlFHrQHDgDtXDH6tTtnNJAsay1kADJYQrwRo18YtgIIkvDnkF
         Pfi4r00oyz6fHyeAKOwZCWWViXWJMUT1nSBTbSO7spzan8Itr3UqToxaA8AfADolObHv
         Qt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794473836; x=1795078636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+IM6c9SQzhSiNLCPJKNescY2jVpZ6DadiC6JkBUJ1jI=;
        b=z4rSJW3dXEAbxyMRzHLqZKVV4AANgDhAMQvxIBuP3OnMiE+huBX0+97amHrhbgHQGY
         0FxnNCoqibSPySEOjNVNrAzaz/VC6N+acgZ6ATCFqy+66ERnPhTjqsc2IdCMXOLtv9p+
         oest6NAh10Va6vXd1gLW08ujZh7iHr8oSinyBgO5/yRGWFxGWn0K69DblgTsD+frSslH
         /FI53uGvSRxXRAI4p8TTiL4sXBeCni4hx1sGwILejhp5biUlE1YpTOj3OYgnM9lYw4pZ
         1V+mcFz23Ro2WsQx8Ry1nyivBeDo4YiuLrl6bgzZCif5g9vKO5sFERSJ0M/prmzcu7Pk
         TO+Q==
X-Forwarded-Encrypted: i=1; AL+hErEuY+C1mFoMSt4jeitSNlWmtv8pJJzFwG0WYnM3+x20Gkn8NzlWIZYnHCfvaAs9tq3RuX5irAw0@vger.kernel.org
X-Gm-Message-State: APuU4Z+eipuW+bPK/cd5SrGfYFoH0LY2iMdc8dsWYCCVAhFupuwu4Vnm
	kJTl5VP1pvKJGyPOp+H6x8ovNG4l4C27halex2HCbV/6i8P3zOthpWIk/+nuq/vkD5xwOi1cDM6
	FrYimrFndjr9TzxAEVuAHa4ePf0mdglO0lBo/4l13tNd9EXc+3KfHqwLT2Tc=
X-Gm-Gg: AYBFou0ef+ufvipKOk31gyfJWUGwvVGAA3JVYC0F9pw3lwKZ3bZvqSczVDDFnDW4Gv0
	ltAyPS/pgR6SfEZrJBww0MJ5oD+GbWXwGMHB3bgCyNzlEKLIt4MojVGNCLNYKICTk9agrS1nvKy
	egqtEXw7tRTgm6O1h8yTHJ0oZFI2MWtIZnYvQzunYt7i27LOJAHoUD9AYy2y5+8cfJAZyBDocHg
	SdAao325e/jNtwdpItRpkUhp+eiYuvQZsRyT86qNyz28pgM00ik0cBSVLoEnbwcpQIdLwcvaMz+
	97ujUzney9+AqyEPt3luBjzAQ1dZwdZRd3lUhLFHBFGilU6Xc6XZd04nYLxNaopdhy195D4M2E9
	UeK2I3wtJBL9TuFHdj64HDtUEasl4DfjO+dxPND7J2I4=
X-Received: by 2002:a05:600c:1c0d:b0:4a2:1e1:d55 with SMTP id 5b1f17b1804b1-4ba093a3cf9mr102100695e9.28.1794473835942;
        Thu, 12 Nov 2026 00:57:15 -0800 (PST)
X-Received: by 2002:a05:600c:1c0d:b0:4a2:1e1:d55 with SMTP id 5b1f17b1804b1-4ba093a3cf9mr102100215e9.28.1794473835545;
        Thu, 12 Nov 2026 00:57:15 -0800 (PST)
Received: from localhost ([139.47.30.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e251686sm54810695e9.3.2026.11.12.00.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:57:15 -0800 (PST)
Date: Thu, 12 Nov 2026 09:57:14 +0100
From: Albert Esteve <aesteve@redhat.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
	Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org
Subject: Re: [Linaro-mm-sig] [PATCH v4 1/8] memcg: Add MEMCG_DMABUF
 accounting infrastructure
Message-ID: <avV_asMMt16Q5S7S@aesteve-thinkpadp1gen8.rmtes.csb>
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-1-1819a017000b@redhat.com>
 <96d6a6e828310738c0cb4550752a0b5808a81ef9.camel@linux.intel.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96d6a6e828310738c0cb4550752a0b5808a81ef9.camel@linux.intel.com>

On Thu, Nov 12, 2026 at 08:26:35AM +0100, Thomas Hellström wrote:
> On Wed, 2026-11-04 at 12:09 +0100, Albert Esteve wrote:
> > From: "T.J. Mercier" <tjmercier@google.com>
> > 
> > Introduce a MEMCG_DMABUF stat counter and helpers for charging,
> > cancelling, and uncharging dma-buf memory against a memory cgroup.
> > 
> > The charge is tracked on struct dma_buf via a new memcg pointer.
> > The memcg reference is stored into (or cleared from) dmabuf->memcg
> > by the helpers, removing the need for callers to manage those
> > details. The release path in dma_buf_release() is reduced to a
> > single mem_cgroup_uncharge_dmabuf() call.
> > 
> > Rather than charging at the page level via __GFP_ACCOUNT, which
> > would require exporters to expose their backing pages for
> > cross-cgroup transfer via new dma_buf_ops, charges are tracked
> > externally on struct dma_buf through a single accounting path.
> > 
> > The next patch wires up the charging policy in the dma-heap ioctl.
> > 
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst |  4 ++
> >  drivers/dma-buf/dma-buf.c               |  3 ++
> >  include/linux/dma-buf.h                 |  4 ++
> >  include/linux/memcontrol.h              | 27 +++++++++++++
> >  mm/memcontrol.c                         | 70
> > +++++++++++++++++++++++++++++++++
> >  5 files changed, 108 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst
> > b/Documentation/admin-guide/cgroup-v2.rst
> > index 86a2a0099178..a3265a4a953e 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1662,6 +1662,10 @@ The following nested keys are defined.
> >  		Amount of memory used for storing in-kernel data
> >  		structures.
> >  
> > +	  dmabuf (npn)
> > +		Amount of memory used for exported DMA buffers
> > allocated by the cgroup.
> > +		Stays with the allocating cgroup regardless of how
> > the buffer is shared.
> > +
> >  	  workingset_refault_anon
> >  		Number of refaults of previously evicted anonymous
> > pages.
> >  
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 4c9add51f9ef..1c6b9cee7ac2 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/fs.h>
> >  #include <linux/slab.h>
> >  #include <linux/dma-buf.h>
> > +#include <linux/memcontrol.h>
> >  #include <linux/dma-fence.h>
> >  #include <linux/dma-fence-unwrap.h>
> >  #include <linux/anon_inodes.h>
> > @@ -182,6 +183,8 @@ static void dma_buf_release(struct dentry
> > *dentry)
> >  
> >  	dmabuf->ops->release(dmabuf);
> >  
> > +	mem_cgroup_uncharge_dmabuf(dmabuf);
> > +
> >  	if (dmabuf->resv == (struct dma_resv *)&dmabuf[1])
> >  		dma_resv_fini(dmabuf->resv);
> >  
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index d15b2b31d3c9..23ec0ff23fba 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -27,6 +27,7 @@
> >  struct device;
> >  struct dma_buf;
> >  struct dma_buf_attachment;
> > +struct mem_cgroup;
> >  
> >  /**
> >   * struct dma_buf_ops - operations possible on struct dma_buf
> > @@ -429,6 +430,9 @@ struct dma_buf {
> >  
> >  		__poll_t active;
> >  	} cb_in, cb_out;
> > +
> > +	/** @memcg: the cgroup to which this buffer is currently
> > attributed */
> > +	struct mem_cgroup *memcg;
> >  };
> >  
> >  /**
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 7d1c0ce189a8..4d1e82cf0833 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -10,6 +10,9 @@
> >  
> >  #ifndef _LINUX_MEMCONTROL_H
> >  #define _LINUX_MEMCONTROL_H
> > +
> > +struct dma_buf;
> > +
> >  #include <linux/cgroup.h>
> >  #include <linux/vm_event_item.h>
> >  #include <linux/hardirq.h>
> > @@ -40,6 +43,7 @@ enum memcg_stat_item {
> >  	MEMCG_ZSWAP_B,
> >  	MEMCG_ZSWAPPED,
> >  	MEMCG_ZSWAP_INCOMP,
> > +	MEMCG_DMABUF,
> >  	MEMCG_NR_STAT,
> >  };
> >  
> > @@ -667,6 +671,9 @@ int mem_cgroup_charge_hugetlb(struct folio*
> > folio, gfp_t gfp);
> >  int mem_cgroup_swapin_charge_folio(struct folio *folio, unsigned
> > short id,
> >  				   struct mm_struct *mm, gfp_t gfp);
> >  
> > +bool mem_cgroup_reserve_dmabuf(struct mem_cgroup *memcg, gfp_t gfp,
> > +			       unsigned int nr_pages);
> > +
> >  void __mem_cgroup_uncharge(struct folio *folio);
> >  
> >  /**
> > @@ -682,6 +689,10 @@ static inline void mem_cgroup_uncharge(struct
> > folio *folio)
> >  	__mem_cgroup_uncharge(folio);
> >  }
> >  
> > +void mem_cgroup_cancel_dmabuf(struct mem_cgroup *memcg, unsigned int
> > nr_pages);
> > +
> > +void mem_cgroup_uncharge_dmabuf(struct dma_buf *dmabuf);
> > +
> >  void __mem_cgroup_uncharge_folios(struct folio_batch *folios);
> >  static inline void mem_cgroup_uncharge_folios(struct folio_batch
> > *folios)
> >  {
> > @@ -1167,10 +1178,26 @@ static inline int
> > mem_cgroup_swapin_charge_folio(struct folio *folio,
> >  	return 0;
> >  }
> >  
> > +static inline bool mem_cgroup_reserve_dmabuf(struct mem_cgroup
> > *memcg,
> > +					     gfp_t gfp,
> > +					     unsigned int nr_pages)
> > +{
> > +	return true;
> > +}
> > +
> > +static inline void mem_cgroup_cancel_dmabuf(struct mem_cgroup
> > *memcg,
> > +					    unsigned int nr_pages)
> > +{
> > +}
> > +
> >  static inline void mem_cgroup_uncharge(struct folio *folio)
> >  {
> >  }
> >  
> > +static inline void mem_cgroup_uncharge_dmabuf(struct dma_buf
> > *dmabuf)
> > +{
> > +}
> > +
> >  static inline void mem_cgroup_uncharge_folios(struct folio_batch
> > *folios)
> >  {
> >  }
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 856a7d07586c..e53dd7eebc3b 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -69,6 +69,7 @@
> >  #include <net/ip.h>
> >  #include "slab.h"
> >  #include "memcontrol-v1.h"
> > +#include <linux/dma-buf.h>
> >  
> >  #include <linux/uaccess.h>
> >  
> > @@ -442,6 +443,7 @@ static const unsigned int memcg_stat_items[] = {
> >  	MEMCG_ZSWAP_B,
> >  	MEMCG_ZSWAPPED,
> >  	MEMCG_ZSWAP_INCOMP,
> > +	MEMCG_DMABUF,
> >  };
> >  
> >  #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
> > @@ -1625,6 +1627,7 @@ static const struct memory_stat memory_stats[]
> > = {
> >  #ifdef CONFIG_HUGETLB_PAGE
> >  	{
> > "hugetlb",			NR_HUGETLB			},
> >  #endif
> > +	{
> > "dmabuf",			MEMCG_DMABUF			},
> >  
> >  	/* The memory events */
> >  	{
> > "workingset_refault_anon",	WORKINGSET_REFAULT_ANON		},
> > @@ -5658,6 +5661,73 @@ void mem_cgroup_flush_workqueue(void)
> >  	flush_workqueue(memcg_wq);
> >  }
> >  
> > +/**
> > + * mem_cgroup_reserve_dmabuf - charge a memcg for a dma-buf
> > allocation
> > + * @memcg: memcg to charge (may be %NULL)
> > + * @gfp_mask: reclaim mode
> > + * @nr_pages: number of pages to charge
> > + *
> > + * Charges @nr_pages against @memcg. Call this before allocating
> > pages so
> > + * the cgroup limit is enforced up front. On success the caller must
> > + * finalize the charge with the MEMCG_DMABUF stat update, or call
> > + * mem_cgroup_cancel_dmabuf() to undo it.
> > + *
> > + * Returns %true on success, %false if the charge would exceed the
> > limit.
> > + */
> > +bool mem_cgroup_reserve_dmabuf(struct mem_cgroup *memcg, gfp_t
> > gfp_mask,
> > +			       unsigned int nr_pages)
> > +{
> > +	if (!memcg || mem_cgroup_disabled())
> > +		return true;
> > +
> > +	if (try_charge(memcg, gfp_mask, nr_pages))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +EXPORT_SYMBOL_GPL(mem_cgroup_reserve_dmabuf);
> > +
> > +/**
> > + * mem_cgroup_cancel_dmabuf - undo a dma-buf charge
> > + * @memcg: memcg to uncharge (may be %NULL)
> > + * @nr_pages: same value passed to mem_cgroup_reserve_dmabuf()
> > + *
> > + * Returns @nr_pages of charge to @memcg. Use when the allocation
> > fails
> > + * after mem_cgroup_reserve_dmabuf().
> > + */
> > +void mem_cgroup_cancel_dmabuf(struct mem_cgroup *memcg, unsigned int
> > nr_pages)
> > +{
> > +	if (!memcg)
> > +		return;
> > +
> > +	if (!mem_cgroup_is_root(memcg))
> > +		refill_stock(memcg, nr_pages);
> > +}
> > +EXPORT_SYMBOL_GPL(mem_cgroup_cancel_dmabuf);
> > +
> > +/**
> > + * mem_cgroup_uncharge_dmabuf - uncharge a dma-buf from its memcg
> > + * @dmabuf: buffer to uncharge
> > + *
> > + * Reverses a finalized dma-buf charge. Drops the memcg
> > + * reference stored in @dmabuf->memcg and clears the pointer.
> > + * Safe to call when @dmabuf->memcg is %NULL.
> > + */
> > +void mem_cgroup_uncharge_dmabuf(struct dma_buf *dmabuf)
> > +{
> > +	unsigned int nr_pages;
> > +	struct mem_cgroup *memcg = dmabuf->memcg;
> > +
> > +	if (!memcg)
> > +		return;
> > +
> > +	nr_pages = PAGE_ALIGN(dmabuf->size) >> PAGE_SHIFT;
> > +	mod_memcg_state(memcg, MEMCG_DMABUF, -nr_pages);
> > +	mem_cgroup_cancel_dmabuf(memcg, nr_pages);
> > +	mem_cgroup_put(memcg);
> > +	dmabuf->memcg = NULL;
> > +}
> 
> Instead of keeping a reference on the memcg for the buffer's whole
> lifetime, shouldn't an obj_cgroup be used, which is reparented when the
> memcg goes offline?

Good point. I did not think of it, but after a brief check I think it'd
be the right object to use. I'll switch for the next version.

> Like in Dave's series here:
> 
> https://lore.kernel.org/all/20260706052330.1110909-1-airlied@gmail.com/

Thanks for the link! I'll use it as reference. I should mention it in the
cover letter too probably, as that series is related (should be safe as
far as it does not opt-in for dma-buf-level charging).

BR,
Albert

> 
> Thanks,
> Thomas
> 
> 
> 
> 
> > +
> >  static int __init cgroup_memory(char *s)
> >  {
> >  	char *token;

