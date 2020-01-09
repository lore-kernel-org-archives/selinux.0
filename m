Return-Path: <SRS0=XIqT=26=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06013C282DD
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 17:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE03D20661
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 17:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="s55t25QL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbgAIRkE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:40:04 -0500
Received: from mailomta29-re.btinternet.com ([213.120.69.122]:30674 "EHLO
        re-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730235AbgAIRkE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jan 2020 12:40:04 -0500
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-043.btinternet.com with ESMTP
          id <20200109174001.DQIF11959.re-prd-fep-043.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Thu, 9 Jan 2020 17:40:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1578591601; 
        bh=owhyv6zioyPhnnzVTmcTDnSyEY9XK617rPDwmZDguXc=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=s55t25QL8mwmIAypHhwwzqOEGZebc6rVdoKr1Rawv9sHqXtzr7224N6CqvrT25yzSHooNPlapeeIPeWjNDE2vk54zM9hTilzUjwTnrDXIK3My2dy8JPta/1JtjlSMYnT4Npmuyuk7kepJXVNrW4Idn7+qGmflVWHjiE3a6ARYbS8w2YZfgSPQQQm++NQ72PVJvCBjreSs+CwcsJjj4C6eKruFIhSoTVB5Y3zt2PWculIxuTeYdPdwEK8fH+u8YZ3bFARb5BkKUaDt8kMir25PdOnaiWbOWVVyXAFcH81UyQXB4T67xfGAi1VGH2FFgdFDONrtZ3sWFJMu3/fjs9/1w==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.185]
X-OWM-Source-IP: 86.134.6.185 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiuddgieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudefgedriedrudekheenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedriedrudekhedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehomhhoshhnrggtvgesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.185) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DE2575E06F3FD88; Thu, 9 Jan 2020 17:40:01 +0000
Message-ID: <a3e10db62ac452eeeb6cc1776835baa846f79368.camel@btinternet.com>
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Add filesystem tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Cc:     omosnace@redhat.com
Date:   Thu, 09 Jan 2020 17:40:00 +0000
In-Reply-To: <26995a97-6d5d-5ae1-914b-25de620c4b5c@tycho.nsa.gov>
References: <20200109150709.360345-1-richard_c_haines@btinternet.com>
         <20200109150709.360345-2-richard_c_haines@btinternet.com>
         <26995a97-6d5d-5ae1-914b-25de620c4b5c@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 2020-01-09 at 12:14 -0500, Stephen Smalley wrote:
> On 1/9/20 10:07 AM, Richard Haines wrote:
> > Test filesystem permissions and setfscreatecon(3).
> > 
> >  From kernels 5.5 filesystem { watch } is also tested.
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> > diff --git a/tests/filesystem/fs_relabel.c
> > b/tests/filesystem/fs_relabel.c
> > new file mode 100644
> > index 0000000..25b1781
> > --- /dev/null
> > +++ b/tests/filesystem/fs_relabel.c
> > @@ -0,0 +1,72 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <stdbool.h>
> > +#include <linux/unistd.h>
> > +#include <selinux/selinux.h>
> > +
> > +static void print_usage(char *progname)
> > +{
> > +	fprintf(stderr,
> > +		"usage:  %s [-v] -n\n"
> > +		"Where:\n\t"
> > +		"-n  New fs context\n\t"
> > +		"-v  Print information.\n", progname);
> > +	exit(-1);
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	int opt, result, save_err;
> > +	char *context, *fscreate_con, *newcon = NULL;
> > +	bool verbose = false;
> > +
> > +	while ((opt = getopt(argc, argv, "n:v")) != -1) {
> > +		switch (opt) {
> > +		case 'n':
> > +			newcon = optarg;
> > +			break;
> > +		case 'v':
> > +			verbose = true;
> > +			break;
> > +		default:
> > +			print_usage(argv[0]);
> > +		}
> > +	}
> > +
> > +	if (!newcon)
> > +		print_usage(argv[0]);
> > +
> > +	if (verbose) {
> > +		result = getcon(&context);
> > +		if (result < 0) {
> > +			fprintf(stderr, "Failed to obtain process
> > context\n");
> > +			exit(-1);
> > +		}
> > +		printf("Process context:\n\t%s\n", context);
> > +		free(context);
> > +	}
> > +
> > +	result = setfscreatecon(newcon);
> > +	save_err = errno;
> > +	if (result < 0) {
> > +		fprintf(stderr, "Failed setfscreatecon(3): %s\n",
> > +			strerror(errno));
> > +		return save_err;
> > +	}
> > +
> > +	result = getfscreatecon(&fscreate_con);
> > +	if (result < 0) {
> > +		fprintf(stderr, "Failed getfscreatecon(3): %s\n",
> > +			strerror(errno));
> > +		exit(-1);
> > +	}
> > +	if (verbose)
> > +		printf("New fscreate context: %s\n", fscreate_con);
> > +
> > +	free(fscreate_con);
> > +	return 0;
> > +}
> 
> I'm a little confused by this test.  setfscreatecon() is normally 
> performed prior to performing some file creation using creat() or 
> open(O_CREAT), mkdir(), symlink(), etc and the expected behavior is
> that 
> the newly created file/directory/link/... will have the specified 
> security context.  I didn't see an explicit test that
> setfscreatecon() 
> followed by one or more file creations yields the expected context
> on 
> the new files, and I don't think we have an explicit test of this 
> functionality in the testsuite currently.

I'll fix in next version (This only tested whether the permission was
allowed or not).

> 
> 
> 

