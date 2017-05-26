Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4Q1xqMh004108
 for <selinux@tycho.nsa.gov>; Thu, 25 May 2017 21:59:53 -0400
Received: by mail-lf0-f66.google.com with SMTP id h4so14713594lfj.3
 for <selinux@tycho.nsa.gov>; Thu, 25 May 2017 18:59:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1495742176.22368.8.camel@tycho.nsa.gov>
References: <1495635523-84017-1-git-send-email-danielj@mellanox.com>
 <1495635523-84017-2-git-send-email-danielj@mellanox.com>
 <1495742176.22368.8.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 May 2017 21:59:42 -0400
Message-ID: <CAHC9VhRKzUO7Q6=C-_z4HwBx=meEjX6-Cr8_WuG6V7XQNivDFw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] selinux-testsuite: Infiniband pkey tests
To: Stephen Smalley <sds@tycho.nsa.gov>, Dan Jurgens <danielj@mellanox.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, May 25, 2017 at 3:56 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2017-05-24 at 17:18 +0300, Dan Jurgens wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>> New tests for infiniband pkeys. Most users don't have Infiniband
>> hardware, and if they do the pkey configuration is not standardized.
>> There is a configuration file for enabling the test and setting
>> environment specific test configurations. If the tests are disabled
>> they
>> will always show as passed.
>>
>> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>

...

>> diff --git a/tests/infiniband_pkey/create_modify_qp.c
>> b/tests/infiniband_pkey/create_modify_qp.c
>> new file mode 100644
>> index 0000000..495ef5b
>> --- /dev/null
>> +++ b/tests/infiniband_pkey/create_modify_qp.c
>> @@ -0,0 +1,144 @@
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <errno.h>
>> +#include <assert.h>
>> +#include <unistd.h>
>> +#include <sys/socket.h>
>> +#include <netinet/in.h>
>> +#include <arpa/inet.h>
>> +#include <infiniband/verbs.h>
>> +
>> +struct ibv_qp           *qp;
>> +struct ibv_context *context;
>> +struct ibv_pd      *pd;
>> +struct ibv_cq      *cq;
>> +struct ibv_srq     *srq;
>> +
>> +void cleanup_ib_rsrc()
>> +{
>> +     ibv_destroy_qp(qp);
>> +     ibv_destroy_srq(srq);
>> +     ibv_destroy_cq(cq);
>> +     ibv_dealloc_pd(pd);
>> +     ibv_close_device(context);
>> +}
>> +
>> +int init_ib_rsrc(char* deviceName)
>> +{
>> +     int                 ndev = 0;
>> +     struct ibv_device  **dlist = ibv_get_device_list(&ndev);
>> +     struct ibv_device  *device = NULL;;
>> +     struct ibv_srq_init_attr srqiattr;
>> +     struct ibv_qp_init_attr qpiattr;
>> +     int i;
>> +
>> +     if (!ndev)
>> +     {
>
> Can you run these test programs through
> astyle --options=none --lineend=linux --mode=c --style=linux --
> indent=force-tab=8 --indent-preprocessor --indent-col1-comments --min-
> conditional-indent=0 --max-instatement-indent=80 --pad-oper --align-
> pointer=name --align-reference=name --max-code-length=80 --break-after-
> logical

FYI, the tools/check-syntax should be able to fixup the sources for you.

-- 
paul moore
www.paul-moore.com
