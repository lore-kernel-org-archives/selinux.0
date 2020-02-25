Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6A9C35E01
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 18:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B730120CC7
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 18:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="ifUZQ3y1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgBYSN0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:13:26 -0500
Received: from mailomta18-re.btinternet.com ([213.120.69.111]:25074 "EHLO
        re-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728367AbgBYSN0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 13:13:26 -0500
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20200225181324.DCYK7315.re-prd-fep-044.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Tue, 25 Feb 2020 18:13:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1582654404; 
        bh=JI1l4DllsYBo1CKbunW+WrAkC6q+S5ZmvHu8WA2cr5A=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=ifUZQ3y1A/5CWBT6SkCxDpdK999q1kDJFx5MrOdb2Wr6SGCuZ2678VMk56lJ2koNbGmaYm0H75sehHIzXiF/A44vOrlZ/izApDBf/cvcxmqDaaH4PraOeHjlCi2XDyfJud5nmNUzv3gPd0E9qsvWXnICglG5ufOEaknPT876FlNZxbRlrx19y+hkqHJ98z48hh9srP7ChYybwV0JEajsyhHVcTlCPw3mJT0SWu1eevOSZtvoqlAvBABlbN57JemJxzb6CxDABUtG652PIfn3HVE8twqQ1KLcUPZp4ePZSnMgKq2mSGHyAjKkqo/F4b/nJ0/DEhGFCuM9pGo0bYThBA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.58.0]
X-OWM-Source-IP: 31.49.58.0 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrledvgddutdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepfedurdegledrheekrddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdehkedrtddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehomhhoshhnrggtvgesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.58.0) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A16DE0330AB22; Tue, 25 Feb 2020 18:13:24 +0000
Message-ID: <d3c9a8fed62999b0162847da0f250c8e40c40255.camel@btinternet.com>
Subject: Re: [PATCH testsuite v2] tests/sctp: fix setting of the SCTP_EVENTS
 sockopt
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Date:   Tue, 25 Feb 2020 18:13:23 +0000
In-Reply-To: <20200225094529.178623-1-omosnace@redhat.com>
References: <20200225094529.178623-1-omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2020-02-25 at 10:45 +0100, Ondrej Mosnacek wrote:
> First, the setting of SCTP_EVENTS socket option in sctp_server.c is
> completely wrong -- it assumes little-endian byte order and uses a
> plain
> int instead of the dedicated sctp_event_subscribe struct.
> 
> Second, the usage in sctp_peeloff_server.c is correct, but it may
> lead
> to errors when the SCTP header definitions are newer than what the
> kernel supports. In such case the size of struct sctp_event_subscribe
> may be higher than the kernel's version and the setsockopt(2) may
> fail
> with -EINVAL due to the 'optlen > sizeof(struct
> sctp_event_subscribe)'
> check in net/sctp/socket.c:sctp_setsockopt_events().
> 
> To fix this, introduce a common function that does what the
> sctp_peeloff_server's set_subscr_events() did, but also truncates the
> optlen to only those fields that we use.
> 
> Fixes: c38b57ffdac4 ("selinux-testsuite: Add SCTP test support")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Just tested this with no problems. Thanks for the fixes.

Acked-by: Richard Haines <richard_c_haines@btinternet.com>

> ---
> 
> v2: check the result of second set_subscr_events() call in
>     sctp_peeloff_server.c
> 
>  tests/sctp/sctp_common.c         | 20 +++++++++++++++++++
>  tests/sctp/sctp_common.h         |  1 +
>  tests/sctp/sctp_peeloff_server.c | 33 +++++++++++++-----------------
> --
>  tests/sctp/sctp_server.c         |  2 +-
>  4 files changed, 35 insertions(+), 21 deletions(-)
> 
> diff --git a/tests/sctp/sctp_common.c b/tests/sctp/sctp_common.c
> index 100ab22..089af2a 100644
> --- a/tests/sctp/sctp_common.c
> +++ b/tests/sctp/sctp_common.c
> @@ -1,5 +1,8 @@
>  #include "sctp_common.h"
>  
> +#define member_size(type, member) sizeof(((type *)0)->member)
> +#define sizeof_up_to(type, member) (offsetof(type, member) +
> member_size(type, member))
> +
>  void print_context(int fd, char *text)
>  {
>  	char *context;
> @@ -99,3 +102,20 @@ void print_ip_option(int fd, bool ipv4, char
> *text)
>  		printf("%s No IP Options set\n", text);
>  	}
>  }
> +
> +int set_subscr_events(int fd, int data_io, int association)
> +{
> +	struct sctp_event_subscribe subscr_events;
> +
> +	memset(&subscr_events, 0, sizeof(subscr_events));
> +	subscr_events.sctp_data_io_event = data_io;
> +	subscr_events.sctp_association_event = association;
> +
> +	/*
> +	 * Truncate optlen to just the fields we touch to avoid errors
> when
> +	 * the uapi headers are newer than the running kernel.
> +	 */
> +	return setsockopt(fd, IPPROTO_SCTP, SCTP_EVENTS,
> &subscr_events,
> +			  sizeof_up_to(struct sctp_event_subscribe,
> +				       sctp_association_event));
> +}
> diff --git a/tests/sctp/sctp_common.h b/tests/sctp/sctp_common.h
> index d5c1397..351ee37 100644
> --- a/tests/sctp/sctp_common.h
> +++ b/tests/sctp/sctp_common.h
> @@ -25,3 +25,4 @@ void print_context(int fd, char *text);
>  void print_addr_info(struct sockaddr *sin, char *text);
>  char *get_ip_option(int fd, bool ipv4, socklen_t *opt_len);
>  void print_ip_option(int fd, bool ipv4, char *text);
> +int set_subscr_events(int fd, int data_io, int association);
> diff --git a/tests/sctp/sctp_peeloff_server.c
> b/tests/sctp/sctp_peeloff_server.c
> index 4a5110a..8350cb4 100644
> --- a/tests/sctp/sctp_peeloff_server.c
> +++ b/tests/sctp/sctp_peeloff_server.c
> @@ -16,24 +16,6 @@ static void usage(char *progname)
>  	exit(1);
>  }
>  
> -static void set_subscr_events(int fd, int value)
> -{
> -	int result;
> -	struct sctp_event_subscribe subscr_events;
> -
> -	memset(&subscr_events, 0, sizeof(subscr_events));
> -	subscr_events.sctp_association_event = value;
> -	/* subscr_events.sctp_data_io_event = value; */
> -
> -	result = setsockopt(fd, IPPROTO_SCTP, SCTP_EVENTS,
> -			    &subscr_events, sizeof(subscr_events));
> -	if (result < 0) {
> -		perror("Server setsockopt: SCTP_EVENTS");
> -		close(fd);
> -		exit(1);
> -	}
> -}
> -
>  static sctp_assoc_t handle_event(void *buf)
>  {
>  	union sctp_notification *snp = buf;
> @@ -166,7 +148,13 @@ int main(int argc, char **argv)
>  	}
>  
>  	do {
> -		set_subscr_events(sock, 1); /* Get assoc_id for
> sctp_peeloff() */
> +		/* Get assoc_id for sctp_peeloff() */
> +		result = set_subscr_events(sock, 0, 1);
> +		if (result < 0) {
> +			perror("Server setsockopt: SCTP_EVENTS");
> +			close(sock);
> +			exit(1);
> +		}
>  		sinlen = sizeof(sin);
>  		flags = 0;
>  
> @@ -192,7 +180,12 @@ int main(int argc, char **argv)
>  				exit(1);
>  			}
>  			/* No more notifications */
> -			set_subscr_events(sock, 0);
> +			result = set_subscr_events(sock, 0, 0);
> +			if (result < 0) {
> +				perror("Server setsockopt:
> SCTP_EVENTS");
> +				close(sock);
> +				exit(1);
> +			}
>  
>  			peeloff_sk = sctp_peeloff(sock, assoc_id);
>  			if (peeloff_sk < 0) {
> diff --git a/tests/sctp/sctp_server.c b/tests/sctp/sctp_server.c
> index 4659ed1..7f2cd20 100644
> --- a/tests/sctp/sctp_server.c
> +++ b/tests/sctp/sctp_server.c
> @@ -134,7 +134,7 @@ int main(int argc, char **argv)
>  	}
>  
>  	/* Enables sctp_data_io_events for sctp_recvmsg(3) for
> assoc_id. */
> -	result = setsockopt(sock, SOL_SCTP, SCTP_EVENTS, &on,
> sizeof(on));
> +	result = set_subscr_events(sock, on, 0);
>  	if (result < 0) {
>  		perror("Server setsockopt: SCTP_EVENTS");
>  		close(sock);

