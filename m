Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22883C433E1
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 12:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D78072075F
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 12:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yGKnSTMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHYMvl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:51:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47946 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHYMvk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 08:51:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PCilxX112615;
        Tue, 25 Aug 2020 12:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=ixHxOsosoizUbLpQlj1KssPo9vyrR+f5BtYiUgnA3Rw=;
 b=yGKnSTMZ4Vi0uGfJTR0ifczqf592Z8LnAWy3gVhqPo2GtKgKIdUejYFfUIcXL5+JYtGs
 O/XcXVJ9JIGUmYy6WUrV10Nv8e1Nr0fK6DHV6TDmA7/M7LPsVDwK3VQiCftjwKmdjtrq
 lwDgl1/7Ytqcth3f/fXJ/Ft61+OFM/+dNL3xkLGQF5v3Iyf4TPcUd/V6K9TSVesL3R7c
 deIMrQyF/WVBAtmPl73Aq99P7Scnzvl1t6iocYvdIC8AXDGKFIJ8ufZvV9+hueQq5YTf
 u1S0OJ3fxIg9Und5JUEVFW4lF2Nzdb2pzIcwamp3s6gsfChaa2lxvPu9LYkqJtsO0shX hw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 333csj2a90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Aug 2020 12:51:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PCils2083086;
        Tue, 25 Aug 2020 12:51:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 333r9juaj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 12:51:37 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07PCpaxj003005;
        Tue, 25 Aug 2020 12:51:36 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Aug 2020 05:51:35 -0700
Date:   Tue, 25 Aug 2020 15:51:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     stephen.smalley.work@gmail.com
Cc:     selinux@vger.kernel.org
Subject: [bug report] selinux: encapsulate policy state, refactor policy load
Message-ID: <20200825125130.GA304650@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=11
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008250097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=11 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250097
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello Stephen Smalley,

The patch 461698026ffa: "selinux: encapsulate policy state, refactor
policy load" from Aug 7, 2020, leads to the following static checker
warning:

	security/selinux/ss/services.c:2288 security_load_policy()
	error: we previously assumed 'newpolicy->sidtab' could be null (see line 2227)

security/selinux/ss/services.c
  2221  
  2222          newpolicy = kzalloc(sizeof(*newpolicy), GFP_KERNEL);
  2223          if (!newpolicy)
  2224                  return -ENOMEM;
  2225  
  2226          newpolicy->sidtab = kzalloc(sizeof(*newpolicy->sidtab), GFP_KERNEL);
  2227          if (!newpolicy->sidtab)
  2228                  goto err;
  2229  
  2230          rc = policydb_read(&newpolicy->policydb, fp);
  2231          if (rc)
  2232                  goto err;
  2233  
  2234          newpolicy->policydb.len = len;
  2235          rc = selinux_set_mapping(&newpolicy->policydb, secclass_map,
  2236                                  &newpolicy->map);
  2237          if (rc)
  2238                  goto err;
  2239  
  2240          rc = policydb_load_isids(&newpolicy->policydb, newpolicy->sidtab);
  2241          if (rc) {
  2242                  pr_err("SELinux:  unable to load the initial SIDs\n");
  2243                  goto err;
  2244          }
  2245  
  2246  
  2247          if (!selinux_initialized(state)) {
  2248                  /* First policy load, so no need to preserve state from old policy */
  2249                  *newpolicyp = newpolicy;
  2250                  return 0;
  2251          }
  2252  
  2253          /* Preserve active boolean values from the old policy */
  2254          rc = security_preserve_bools(state, &newpolicy->policydb);
  2255          if (rc) {
  2256                  pr_err("SELinux:  unable to preserve booleans\n");
  2257                  goto err;
  2258          }
  2259  
  2260          /*
  2261           * Convert the internal representations of contexts
  2262           * in the new SID table.
  2263           *
  2264           * NOTE: We do not need to take the policy read-lock
  2265           * around the code below because other policy-modifying
  2266           * operations are already excluded by selinuxfs via
  2267           * fsi->mutex.
  2268           */
  2269          args.state = state;
  2270          args.oldp = &state->ss->policy->policydb;
  2271          args.newp = &newpolicy->policydb;
  2272  
  2273          convert_params.func = convert_context;
  2274          convert_params.args = &args;
  2275          convert_params.target = newpolicy->sidtab;
  2276  
  2277          rc = sidtab_convert(state->ss->policy->sidtab, &convert_params);
  2278          if (rc) {
  2279                  pr_err("SELinux:  unable to convert the internal"
  2280                          " representation of contexts in the new SID"
  2281                          " table\n");
  2282                  goto err;
  2283          }
  2284  
  2285          *newpolicyp = newpolicy;
  2286          return 0;
  2287  err:
  2288          selinux_policy_free(newpolicy);

This style of "one function frees everything" error handling is the
most bug prone style of error handling.  Typical bugs are:

1) Free uninitalized memory.

2) Decrement reference counts which weren't incremented.

3) Rely on things to be allocated like this example where
   "newpolicy->sidtab" is NULL.

4) Double free things because other code is written in the style where
   each function cleans up its own allocations.  For example, in this
   case policydb_read() calls policydb_destroy(p); and
   selinux_policy_free() calls it as well so it is a double free.
   There are some other double frees on this path as well.

5) Leaks because the code is hard/impossible to audit.

The best way to write error handling is to use "Free the most recent
allocation" style.  Use good label names, like "err_free_foo: kfree(foo);"
which say what the goto frees.  That way we never free uninitialized
memory.  It's easy to audit because we just have to mentally keep
track of the most recent allocation and we check that "goto free_foo;"
matches that foo is the recentest allocation.

  2289          return rc;
  2290  }

regards,
dan carpenter
