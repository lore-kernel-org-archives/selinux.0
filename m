Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794657339;
	b=J4TbDJK6p0ZbVR1kAd30MnbJeIGiifrEukhyHrEE9eadmSNzrlCiLHCjA9trnTW3OyEL
	 ii++lI4x/SqtkPiHmYurpunhbxnrJ+hlTFoWzT59+C2CgPfUKComBIVVrN7DMfOWXf97W
	 zA8AVQAIWBZkahOolc2hDLXWUCLorHBI5BWPvuXBc9pd/HZwAmNo/niTRCUQlgP6Hz90T
	 K7lW0GfuyZcuMGv1qiQ7jk0y97cv4uia2XAgWtITjGMJdtYA0TRr2FHpz4grBYQLMwMi0
	 EqSHAa/TOh4yruoujV4KVo4ql8FCaHMLvxCh8x+0uhUXqaXYEwgWg2R0djcWzSNoWNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794657339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
	b=HBx2ROPnQV+3WYKw9PlUo0ZAtarZexJ3uyckNfzTL7AGmHZyDvKOy1dg6I0OlEV7YUEZ
	 S7LLp/EHXMjI//AEHgvipewviVJN7xTK0Q9Fl+VUw+T6359ORdPBloUBOE25mhwRIM6pu
	 mZmket2cVSUWxQRI3Rw0tkatJzCh36+hkjuBN/cLBX0xeBBBDs9priT6uimUwTnBem4vT
	 82mIkZCuSkd/vkOn+t/mCvdeNTBdq2WXMUB6Xoh6p2t6LfxSkv3zVVjMveMLUXdxU/YWT
	 6Og26kzfnLnbfwAgcrvpN++AdNOCYbWnwYo08Ej2CZqlQL3ESKIticuu/UEMVX+ml1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MrTBjpIE;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C52B606A337
	for <selinux@vger.kernel.org>; Sat, 14 Nov 2026 11:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C52B606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MrTBjpIE
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c50ac25cdd4so132868066b.1
        for <selinux@vger.kernel.org>; Sat, 14 Nov 2026 03:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794657337; x=1795262137; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
        b=MrTBjpIEXzsSZaANjc7oExJhwGnF+j3pBQoJGLV3AozjECewWnT/dOn8PoCfUIeYGI
         mRgldWBhVoyoY4kjpOu/TkcCPMpetn8bMN74Irqnk0JnK5MAQS777TE3iVfENO0qNvUE
         8qb82pxhdLikkA/6tATGUpByZMee1vHTbdl6A6vtosorr3+hE9wD/mpuH76lS1WAZqyn
         nUdTyabyG8UAyWqGnpYJGfY62DgpvBldD5kNADP5MARyaYxmHHJYDsQkr6qVKrnaldzF
         KHIyaxdpU8Pcl80WjVwUUXXw+yU81KD0D8RdN7wE6Dhf//BzElFXAKq/AgQBu3vGzFII
         7JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794657337; x=1795262137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nJvs09p7QWIuuw8YOzj5TR133+2IJ5+yRajckn/hsO0=;
        b=X+RFNKJytapyt93Yb73P6kGnWxh3IsneTVPJSUzIZzpQLKcmVazuoMS+aYentw1KQH
         4XcB1WdbT0wqQo2eRLFQXG8qO2ogr1t3027XXUzQDEAjF4shIzt7xb9YlvHQVrby0FI9
         YjM+SiVYj5gvCfQDQosHRasVnQBirqiGsAolsQ1e5IQ9ro3gsUKA36XC/hUo6On+Wc4/
         KGh3w8dDGtDYbWeJYdIVT/X2BFTrrp7rv0wanPe3C0KW7QwtXahYEgkxgWOOfbpRIklC
         cWYLpd77zn8UhLxIVZdRkDGl8pmvd8Xx8G8kXSaSFFwbF9Osex4GcPE7WPDfxrFLc7/R
         +NxA==
X-Forwarded-Encrypted: i=1; AL+hErGXz4OgiRZ06ZoX1Sd6k+MgoO4dum7XEXirF09i9qIxVPC+9C/+YGAzfh7sabCDIJR8yS+XWZoP@vger.kernel.org
X-Gm-Message-State: APuU4Z8BDBFJ3BO4HZtAECBJ6UamPsddqU84z6YPOSky/nw8oJ8iPX7B
	RsouGHLEN+I7afsXzt+oHPPy49/TchaEZXO3nMqMfbSxorKvtgsWPUu+
X-Gm-Gg: AYBFou2lcQHe9ICUhk3LgMLDisYeFBPNxdvu8MeBT7MihDDjJddUe8GPN8JileULrjd
	lT3yybZykPvIiEhoOsYFHpsRN2N32BFg3rDWBV/N7v/vM+UuzOsPEAwzWphypqe0tcX6WnpWzPm
	pn49yFmweqLv5lpo4foWWAA87DuuW/Ji0xn8C1V76OXfAehQADgHIugcwYX/LNwaxaICoD1MQbz
	Pj7yLukuCNAhUow6Bo/Jk+tpeX1ynQeK66MdowvOsWXhwRS6FOzAhobrvJF7KjVw0z6iFgu1uV8
	CJD6UuFg99sCLhTd0AkfPH9okRiKeu4wDUopH+FqVQVWlXT0/gfT5dDruV7KMorxlOfS/PooZNW
	2R8F+aLowpxiM56arKMm3i3K9QLCxUT2RM3P0yd2++56ZMuHRAGM60XrrOBIxTQ8GMLJJJz7iD8
	W/dRSuUd0pyhHMIE1mkXWd0dX0N09rObPv1iAFH/6SO4ykwac6XUlAwoAF0s6mTtEFv77Ga5jGA
	6uyA9kWuvQpFc5j3uQdNIFhxsoWR9i6R9ZqXe2Qwv5kmPmSQ4HnlLOG8pxQ+sEPYEx2lclNNP3P
	xXpKyLGIkNoAC81kjqsl7sMvBvB0GgAOco9Z4kmTgZPutIuNfMmKggGEUf3btOYi89A6euL6vDI
	aZqlkACw3nPI=
X-Received: by 2002:a17:907:3e10:b0:c40:231:6eab with SMTP id a640c23a62f3a-c5096370c31mr441592966b.16.1794657336589;
        Sat, 14 Nov 2026 03:55:36 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b41f44sm206223866b.31.2026.11.14.03.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:55:36 -0800 (PST)
Date: Sat, 14 Nov 2026 12:55:35 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Alexander Mikhalitsyn <alex@amutable.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
Message-ID: <avhMN39TECaur0sS@amir-ThinkPad-T480>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
 <20261111151202.GA11391@lst.de>
 <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>
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
In-Reply-To: <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>

On Fri, Nov 13, 2026 at 11:25:57AM +0100, Alexander Mikhalitsyn wrote:
> Hi Christoph,
> 
> On Wed, 2026-11-11 at 16:12 +0100, Christoph Hellwig wrote:
> > I've seen setups where people use fuse to mediate access to sysfs
> > sysfs in odd ways.  No idea if that's still around, but if so, this
> > patch will break it.
> 
> 
> Oh, that's painful. Do they use backing files for that?
> It's a relatively new feature in FUSE...
> 

Very unlikely that they use FUSE passthrough and if they did
very unlikely that it would break their filesystem.

The API for fuse passthrough is that the server requests to setup a
backing file before open via ioctl and if ioctl fails (as this patch
does) then server falls back to non-passthrough open.

The ioctl can already fail for many reasons such as MAX_STACK_DEPTH on
procfs as the commit message says, so server needs to cope with the
fall back.

Thanks,
Amir.
