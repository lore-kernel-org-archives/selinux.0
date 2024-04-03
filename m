Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4551401C
	for <selinux@vger.kernel.org>; Wed,  3 Apr 2024 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133483; cv=none; b=ilogvej8fjh8xkRafH0A8ZRADNfyexlGN9v1P7A7nvhKqurjn7sD6CTBOIsUd1uJV4BBCFHgwo/hbToI/aMK4Ju3JPelVz9vnP9uFdYvMPvUe3tP6j37Sfky4/pEs0+4zfuApFJU1Alq02zbX4qORXHGn4+8psuH8s3oy8iClt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133483; c=relaxed/simple;
	bh=rJjf7bdTQKiwRyt0JEIkj8tBZw5T/hgVMRyndOgqqM4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V+JU7qX4uhODj9maRho2XvNT6HIcU9gkShxm/75clJtLxNuXgENOys6P+2J4gZWeP00zHXHfiPv0eV6Wuf//UPa0QZhgwzbFcQCgDuQizb3HpzCxrmdCB74h+KEAoGI0MG12ifg1Tu36XptQsoekSulCiHeya2ufPNM2MeiyJRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dbyep5jO; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dbyep5jO"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4715991c32so782748766b.1
        for <selinux@vger.kernel.org>; Wed, 03 Apr 2024 01:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712133480; x=1712738280; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=reR/WmEQdEdWoNp67nsQ0qX+Iy6R3PKHOBYd7bFcoXM=;
        b=Dbyep5jOUsEonNMPpQ/6taAzngAzQ6ArV8ewzes5+xcW8l7w0PMYpp3UQ4zDfPPkGe
         66VUQ4BHsJKqeFSC1F1MvLwQLUd+NGWYIm/A3X9OhuVCSCKfxakKPnIyMiGAzNd8ZO49
         3uhtSUrvGAk9YWKCs7uqlq117zk6a4kMZUae6Xz/YNToUlxeFDLtL0X37mZDC8WxfmzV
         maebPISZZzIOYRaewiG137dbA6tmu58zd3IRgzLiL3o+vXeXZg2yKmTLcJnNczeHyQLj
         iiyL0TKSCFd74KPAMP5pWTvwaj4DSwEOkcyhVsO4tOUhJPr0mpajZEPT4YIZNQlPtNkt
         pwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712133480; x=1712738280;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=reR/WmEQdEdWoNp67nsQ0qX+Iy6R3PKHOBYd7bFcoXM=;
        b=SVvXthUXHh3iTG2JJ+Zl1M30shZXzsGnX3GSJX7tltvIfzlpd3mtSiUCBR/UsrOu4r
         gX+uN7N5MLtEDOsk7ungwHRxtMsWpUtYY1PQUrmrVARfgh75TlrKVP6nM/8Q3T4T4bd6
         q7xtOtZnNSeif+rjIhahIT/Og7qxW/Hngh9EkMFWNunyRkYAFmf0tD3FJ/v+9rciiIte
         E4PLjz8nlJgZShuUc2TM4p5tjYPTbuqkLPudjc+0Hl7E9gvCRsUnMvgABzlxhpvfD0f5
         iqUS9KXz5U71t8d7bemPK80lQdtoGrmE2HVRcF7E6wOMvDLJi6yqsGAYQiqjOf6OUyGM
         avxA==
X-Gm-Message-State: AOJu0YwP8hZECbPMi5bK0OrXHMtD1tR/cNb8UCCgNUaQjpyJwTO+WqHE
	/vXxJ2PlYAroaeu+ciAZdVpVpQ0/zwW6tEsoaN/PwcX31veOiT50gXCkLjLFqIg=
X-Google-Smtp-Source: AGHT+IGIhamhMLEOrYUSgT0/PmlMtxyKeBn9ddDtkFDoY8fjcmfcg7l7ICvS8lyZTM3zBjDPxLpwVg==
X-Received: by 2002:a17:906:8d5:b0:a46:1d4b:d81 with SMTP id o21-20020a17090608d500b00a461d4b0d81mr9928248eje.62.1712133479950;
        Wed, 03 Apr 2024 01:37:59 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id kf16-20020a17090776d000b00a46bf6d890bsm7558000ejc.91.2024.04.03.01.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:37:59 -0700 (PDT)
Date: Wed, 3 Apr 2024 11:37:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: omosnace@redhat.com
Cc: selinux@vger.kernel.org
Subject: [bug report] selinux: optimize storage of filename transitions
Message-ID: <722b90c4-1f4b-42ff-a6c2-108ea262bd10@moroto.mountain>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Ondrej Mosnacek,

Commit c3a276111ea2 ("selinux: optimize storage of filename
transitions") from Feb 18, 2020 (linux-next), leads to the following
Smatch static checker warning:

	security/selinux/ss/policydb.c:1953 filename_trans_read_helper_compat()
	warn: missing error code 'rc'

security/selinux/ss/policydb.c
    1916 static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
    1917 {
    1918         struct filename_trans_key key, *ft = NULL;
    1919         struct filename_trans_datum *last, *datum = NULL;
    1920         char *name = NULL;
    1921         u32 len, stype, otype;
    1922         __le32 buf[4];
    1923         int rc;
    1924 
    1925         /* length of the path component string */
    1926         rc = next_entry(buf, fp, sizeof(u32));
    1927         if (rc)
    1928                 return rc;
    1929         len = le32_to_cpu(buf[0]);
    1930 
    1931         /* path component string */
    1932         rc = str_read(&name, GFP_KERNEL, fp, len);
    1933         if (rc)
    1934                 return rc;
    1935 
    1936         rc = next_entry(buf, fp, sizeof(u32) * 4);
    1937         if (rc)
    1938                 goto out;
    1939 
    1940         stype = le32_to_cpu(buf[0]);
    1941         key.ttype = le32_to_cpu(buf[1]);
    1942         key.tclass = le32_to_cpu(buf[2]);
    1943         key.name = name;
    1944 
    1945         otype = le32_to_cpu(buf[3]);
    1946 
    1947         last = NULL;
    1948         datum = policydb_filenametr_search(p, &key);
    1949         while (datum) {
    1950                 if (unlikely(ebitmap_get_bit(&datum->stypes, stype - 1))) {
    1951                         /* conflicting/duplicate rules are ignored */
    1952                         datum = NULL;
--> 1953                         goto out;

It's not clear just from looking at this, if it should return zero or an
error code.  The way to silence these warnings in smatch is to add a
"rc = 0;" within 5 lines of the goto.  Or a comment would also help
reviewers.

    1954                 }
    1955                 if (likely(datum->otype == otype))
    1956                         break;
    1957                 last = datum;
    1958                 datum = datum->next;
    1959         }
    1960         if (!datum) {
    1961                 rc = -ENOMEM;
    1962                 datum = kmalloc(sizeof(*datum), GFP_KERNEL);
    1963                 if (!datum)
    1964                         goto out;
    1965 
    1966                 ebitmap_init(&datum->stypes);
    1967                 datum->otype = otype;
    1968                 datum->next = NULL;
    1969 
    1970                 if (unlikely(last)) {
    1971                         last->next = datum;
    1972                 } else {
    1973                         rc = -ENOMEM;
    1974                         ft = kmemdup(&key, sizeof(key), GFP_KERNEL);
    1975                         if (!ft)
    1976                                 goto out;
    1977 
    1978                         rc = hashtab_insert(&p->filename_trans, ft, datum,
    1979                                             filenametr_key_params);
    1980                         if (rc)
    1981                                 goto out;
    1982                         name = NULL;
    1983 
    1984                         rc = ebitmap_set_bit(&p->filename_trans_ttypes,
    1985                                              key.ttype, 1);
    1986                         if (rc)
    1987                                 return rc;
    1988                 }
    1989         }
    1990         kfree(name);
    1991         return ebitmap_set_bit(&datum->stypes, stype - 1, 1);
    1992 
    1993 out:
    1994         kfree(ft);
    1995         kfree(name);
    1996         kfree(datum);
    1997         return rc;
    1998 }

regards,
dan carpenter
