Return-Path: <SRS0=UID1=TY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BC0C072B5
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 18:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C0F217D7
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 18:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="B+0XcSNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfEXSlT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 May 2019 14:41:19 -0400
Received: from 48.23.240.77.static.louhi.net ([77.240.23.48]:32796 "EHLO
        kolttonen.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbfEXSlS (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 24 May 2019 14:41:18 -0400
X-Greylist: delayed 3502 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 May 2019 14:41:16 EDT
Received: from 34-41-5D-CA-59-C7 (176-93-196-243.bb.dnainternet.fi [176.93.196.243])
        (authenticated bits=0)
        by vcust561.louhi.net (8.14.7/8.14.7/0) with ESMTP id x4OHeVfb009957
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 24 May 2019 20:40:32 +0300
DKIM-Filter: OpenDKIM Filter v2.11.0 vcust561.louhi.net x4OHeVfb009957
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolttonen.fi;
        s=mail; t=1558719633;
        bh=8ktpfANQmRDmKI3nMQmGZR04AJcscJJWdOdO6X+QUpg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=B+0XcSNde+BgSWjDC6IEqqhFgL9m1fo0Rhwa3UqX8lFVmTxRudVQA6onnC2iBYZKt
         I0r5IMoWjoZ7Oqq1x/3UfMXBFsgRoEPO6jizLmIvuhVz7XbMlSasKGI+OO3KwBPj4G
         /vgz1FK9cEUdcsm4h/o0XoqcAI2yb8mmFruBE+N5ad3potzJ7kTQ2n//QIoEihOHyM
         6vdwNNqvEw74z9UWKDNc1Iave9ll8ibpFjYuEfrajhK3Ct30svrIO9BBkgnkYBph6F
         nYskz9xcfNgcfqX1tIgsL4PDQbvgERcUf5Xv02a1oLv9ySX4Ao0ArLviewSVJPzbw0
         SKO/2EJ/D6Lag==
Date:   Fri, 24 May 2019 20:40:40 +0300 (EEST)
From:   selinux@kolttonen.fi
To:     Stephen Smalley <sds@tycho.nsa.gov>
cc:     selinux@vger.kernel.org
Subject: Re: [PATCH] conf-parse.y checks (with style fixes removed)
In-Reply-To: <2f749de1-4965-2be5-6415-6389a10fd38f@tycho.nsa.gov>
Message-ID: <alpine.LFD.2.21.1905242034320.5682@34-41-5D-CA-59-C7>
References: <alpine.LFD.2.21.1905181955170.29988@34-41-5D-CA-59-C7> <2f749de1-4965-2be5-6415-6389a10fd38f@tycho.nsa.gov>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463786495-786318264-1558719641=:5682"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463786495-786318264-1558719641=:5682
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT


On Fri, 24 May 2019, Stephen Smalley wrote:

> I wouldn't put the variable name/field name into the error message. "could not
> allocate memory for ignoredirs" would suffice.

Agreed. I will fix it.
 
> > +	}
> >    	free($3);
> >    }
> >   @@ -240,8 +243,8 @@ handle_unknown: HANDLE_UNKNOWN '=' ARG {
> >   bzip_blocksize:  BZIP_BLOCKSIZE '=' ARG {
> >    int blocksize = atoi($3);
> >    free($3);
> > -	if (blocksize > 9)
> > -		yyerror("bzip-blocksize can only be in the range 0-9");
> > +	if (blocksize < 1 || blocksize > 9)
> > +		yyerror("bzip-blocksize can only be in the range 1-9");
> >    else
> >   		current_conf->bzip_blocksize = blocksize;
> >   }
> > @@ -339,9 +342,18 @@ static int semanage_conf_init(semanage_conf_t * conf)
> >   {
> >    conf->store_type = SEMANAGE_CON_DIRECT;
> >    conf->store_path = strdup(basename(selinux_policy_root()));
> > +	if (conf->store_path == NULL) {
> > +		return -1;
> > +	}
> >    conf->ignoredirs = NULL;
> >    conf->store_root_path = strdup("/var/lib/selinux");
> > +	if (conf->store_root_path == NULL) {
> > +		return -1;
> > +	}
> >   	conf->compiler_directory_path = strdup("/usr/libexec/selinux/hll");
> > +	if (conf->compiler_directory_path == NULL) {
> > +		return -1;
> > +	}
> >    conf->policyvers = sepol_policy_kern_vers_max();
> >    conf->target_platform = SEPOL_TARGET_SELINUX;
> >    conf->expand_check = 1;
> > @@ -515,7 +527,10 @@ static int parse_module_store(char *arg)
> >     	}
> >    	}
> >   	}
> > -	return 0;
> > +
> > +	if (current_conf->store_path)
> > +		return 0;
> > +	return -3;
> >   }
> >   
> >   static int parse_store_root_path(char *arg)
> > @@ -526,6 +541,10 @@ static int parse_store_root_path(char *arg)
> >   
> >    free(current_conf->store_root_path);
> >    current_conf->store_root_path = strdup(arg);
> > +	if (current_conf->store_root_path == NULL) {
> > +		return -2;
> 
> Not sure why we are using multiple error return codes here or what they mean.

I think some of the existing code in this file used "return -1" and 
"return -2", so I followed that choice just in case someone would be 
interested in inspecting why the functions failed. 

As of now, the callers do not care more specifically than checking for 
non-zero, but if someone would run the code in e.g. a debugger, it might 
be good to have separate return values for different errors - I am not 
sure, though.

If you want all errors to be -1, I can of course do that?

Regards,
Jokke Hämäläinen
---1463786495-786318264-1558719641=:5682--
