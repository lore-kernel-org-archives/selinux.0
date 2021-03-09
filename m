Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F9BC433DB
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 17:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52BC565238
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 17:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhCIRUB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Mar 2021 12:20:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:17003 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231414AbhCIRTf (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 9 Mar 2021 12:19:35 -0500
IronPort-SDR: 30vCai6X40X7+fSLgjOYEonF/aPFYzo0FyU/rmvHlttepXedBbjHLR42voUkG5BrnXQS0oOqrA
 MBvO6JLICcTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="188326950"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="gz'50?scan'50,208,50";a="188326950"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 09:19:35 -0800
IronPort-SDR: 0KEVR7Ol5zxGbuWMwItk28xJKYCeK6zzRf19msmRnIfYrc1uYFbwBlPuIoqll1of1sMFarMEZ+
 z6Nm2uniEl9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="gz'50?scan'50,208,50";a="520395893"
Received: from lkp-server01.sh.intel.com (HELO 3e992a48ca98) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Mar 2021 09:19:31 -0800
Received: from kbuild by 3e992a48ca98 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lJg15-0001kB-1T; Tue, 09 Mar 2021 17:19:31 +0000
Date:   Wed, 10 Mar 2021 01:19:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     kbuild-all@lists.01.org, casey@schaufler-ca.com,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com
Subject: Re: [PATCH v25 22/25] Audit: Add new record for multiple process LSM
 attributes
Message-ID: <202103100129.jHErl9Wx-lkp@intel.com>
References: <20210309144243.12519-23-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20210309144243.12519-23-casey@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Casey,

I love your patch! Yet something to improve:

[auto build test ERROR on nf/master]
[also build test ERROR on linus/master v5.12-rc2 next-20210309]
[cannot apply to pcmoore-audit/next nf-next/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Casey-Schaufler/LSM-Infrastructure-management-of-the-sock-security/20210309-234224
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git master
config: powerpc-mpc85xx_cds_defconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/cfacc4ba1644ab90394c02c84f60ac35476463fa
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Casey-Schaufler/LSM-Infrastructure-management-of-the-sock-security/20210309-234224
        git checkout cfacc4ba1644ab90394c02c84f60ac35476463fa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/ptrace/ptrace.c:20:
   include/linux/audit.h:579:1: error: expected identifier or '(' before '+' token
     579 | +static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
         | ^
>> include/linux/audit.h:261:13: error: 'audit_log_lsm' defined but not used [-Werror=unused-function]
     261 | static void audit_log_lsm(struct audit_context *context)
         |             ^~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/audit_log_lsm +261 include/linux/audit.h

   216	
   217	#else /* CONFIG_AUDIT */
   218	static inline __printf(4, 5)
   219	void audit_log(struct audit_context *ctx, gfp_t gfp_mask, int type,
   220		       const char *fmt, ...)
   221	{ }
   222	static inline struct audit_buffer *audit_log_start(struct audit_context *ctx,
   223							   gfp_t gfp_mask, int type)
   224	{
   225		return NULL;
   226	}
   227	static inline __printf(2, 3)
   228	void audit_log_format(struct audit_buffer *ab, const char *fmt, ...)
   229	{ }
   230	static inline void audit_log_end(struct audit_buffer *ab)
   231	{ }
   232	static inline void audit_log_end_local(struct audit_buffer *ab,
   233					       struct audit_context *context)
   234	{ }
   235	static inline void audit_log_n_hex(struct audit_buffer *ab,
   236					   const unsigned char *buf, size_t len)
   237	{ }
   238	static inline void audit_log_n_string(struct audit_buffer *ab,
   239					      const char *buf, size_t n)
   240	{ }
   241	static inline void  audit_log_n_untrustedstring(struct audit_buffer *ab,
   242							const char *string, size_t n)
   243	{ }
   244	static inline void audit_log_untrustedstring(struct audit_buffer *ab,
   245						     const char *string)
   246	{ }
   247	static inline void audit_log_d_path(struct audit_buffer *ab,
   248					    const char *prefix,
   249					    const struct path *path)
   250	{ }
   251	static inline void audit_log_key(struct audit_buffer *ab, char *key)
   252	{ }
   253	static inline void audit_log_path_denied(int type, const char *operation)
   254	{ }
   255	static inline int audit_log_task_context(struct audit_buffer *ab)
   256	{
   257		return 0;
   258	}
   259	static inline void audit_log_task_info(struct audit_buffer *ab)
   260	{ }
 > 261	static void audit_log_lsm(struct audit_context *context)
   262	{ }
   263	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ikeVEW9yuYc//A+q
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICFaoR2AAAy5jb25maWcAnFzrc9u2sv/ev4KTfmlnTnts+dFk7vgDBIISKpKgAVCS/YWj
2EyqqSP5SnLr/Pd3F3wBFChl7pk5TYRdvPfx28UyP//0c0DeDttvq8P6afXy8j34Wm7K3epQ
Pgdf1i/l/wShCFKhAxZy/Tswx+vN2/t/X7f/lrvXp+Dm98vL3y+CWbnblC8B3W6+rL++Qe/1
dvPTzz9RkUZ8UlBazJlUXKSFZkt996Hu/dsLjvXb16en4JcJpb8Gn36/+v3ig9WNqwIId9+b
pkk31N2ni6uLi5Y3JumkJbXNcYhDjKOwGwKaGrbR1XU3QmwRLqwlTIkqiEqKidCiG8Ui8DTm
KetIXN4XCyFnXcs453GoecIKTcYxK5SQuqPqqWQE1plGAv4DLAq7wun9HEzMVbwE+/Lw9tqd
51iKGUsLOE6VZNbEKdcFS+cFkbAdnnB9dzWCUZoliyTjMLtmSgfrfbDZHnDgdv+Ckrg5gA8f
fM0Fye0zMNsqFIm1xT8lc1bMmExZXEweubU8mxI/JmSIYs3gjtPuxBrE3sgxXXj2GbKI5LE2
p2Wtu2meCqVTkrC7D79stpvy15ZBLYi1GfWg5jyjRw34J9WxvdpMKL4skvuc5cy73AXRdFoc
0Ztrk0KpImGJkA8F0ZrQqT16rljMx95xSQ4q6xnRHDeRMKfhwBWTOG5kDsQ32L993n/fH8pv
ncxNWMokp0a61VQsLJ3sUYqYzVns6kMoEsJTty0SkrKwFn+eTqyzzIhUDJnMTsvNc7D90ltY
f3ajXvNuLz0yBTmewbpSrTzERKgiz0KiWXMKev2t3O19B6E5nYHqMdiqpcSpKKaPqGKJSO3r
gcYM5hAhp56bqHrxMGa9kSzd4JNpIZkyG5TKPpCjNTZ9MslYkmkYytilThLr9rmI81QT+eAV
m5rLppkjoVn+X73a/x0cYN5gBWvYH1aHfbB6etq+bQ7rzdfeIUGHglAqYK7qetsp5lzqHrlI
ieZzv4KgtJj77di9fGMVwuoFZaAwwKq9TGhflSZa+TevuNten/UPbN4ckqR5oHxCkz4UQLMP
AX4WbAnS4dNRVTHb3VXTv16SO5V1WrPqL/6jnE1B20CQvB4AbXoESswjfXd53YkTT/UMDH3E
+jxX1a7V01/l89tLuQu+lKvD267cm+Z6oR6q5ZUmUuSZ/zLQDoMtgPv0kumU0VkmYHGoIFpI
v/Qo4AuN6zJT+XkeVKTAB4DsU7ACoZdJspg8eM5tHM+g69x4FBm6/liSBAZWIgdbZ3kbGfac
IzSMoWHktLheEhqWjz266P2+dn4/Kh3aEjcWAtTuSDg6SCMyUDP+yNA2o92CPxKSUseI9NkU
/GXIyQA8CBHbUBGyAswrKRjiElR110yeZPSJalgImU1JCs5Tpo4Xrryv8xvUjLJMG/wpCbWM
7TiLuh+VMna/E8ADHPyrtMabMJ2AASmOHE0lQUfNEazRMe8VGmiNuaNiNrSy3CGLIzgYaS+b
gHuMcmeiHKB172eRcWuUTDjr5ZOUxDYwNmuyG4y7tBvUFGBI95NwS/y4KHLpeHESzjkssz4S
a7MwyJhIye2DnSHLQ6IcmFe3FfCnRwZasjkNVE50II68Z1EzvVeh8W4N6otCz/gGISHI79Zb
4FBjQmfWbnxs6iGlzZV126FJ5pkGkM69zRYyuHzT6l0zTMLCkPkWbFQOtbZogU7n1+jlxfWR
S6/Dtqzcfdnuvq02T2XA/ik34NcImG6Kng0QRuX963G64b1+8gdHbJY8T6rBCuPXHZVQcT6u
DsOKuiCEIRrin5m9NxWTsc+FwgAum/CzkTHcnZywJgboj11EgIhirsDNgDKLxO9BHMYpkSGA
S78fUdM8iiAQywjMCQIFERY4rwEsJiIeH+Gd+rDd8LC1JRm9Gjl3n9Hb47vPdtuncr/f7gBA
vr5udwfnmiGSAW8xu1LF1chzaEj/ePP+3pum+Pj+7t3H9cVA+/W7Z/QWl2cOYGI3NxcX2OhX
jFsPte15cdFfKrYlPlCOxAiwqWQTSxwjFaPuGQWoMH7nVGfM5es1mQHr5isXkE8fVHF7PfaG
aSpj6C0UH9v+A1rdkZMkB6APBmg61F5cjVxStRDkcBYDHYwX8wut13jhaKEQcszi2Mamx8LV
anyohL0ejALGeEVpyIl1rFcjOBXLZyR5z+QmCckKmQJughC2SMjy7vKPUwwQfl5e+hkas3Ju
IIfPGS+VGKSou5vLUXtREKnPDNwoVJ5lbsrHNEOPKCYTdUzHYBXA6DGh0YzpgkFcqJ1r7d1x
7YpSARJj0RiR8cMR3shIWsfQIgdY/7FNgFXgWSRcg3EDOF4YvG177uqIyEPtfkDUw95S8nA8
KS5vQXutXph5MH2PN+eYfKux9fHNIiz1bNI3OU/Aqva9Mx8zWWFJj0YZFpXDMcEVD5LNRWCW
QIoxU+4GAek0btuxGS6NE6ruRn5aeIo2B1p7IdmkyiGaJAv2qYz5y+qADtey5ZY9UoK2NskK
lumny6tLiBP82SM6+nQF18n9QVXVe1Tch35zkWT04831BWzjBP32iG5T398LGjogpmlOTg16
dVucIkP3M+ShA8kuLy4vTlFHo6GhK6IMZ4PUq8GB9UIaDr8DhauVELD6p50pjofspS2Zanbs
H1gvi0l25V/SfYKXe4J2eYL2cZh2czNMG9iHGtPBMbOMDNIAevEku/InkJN5wkaADwZGpcU9
A2fJhjgQ+adMN7bLfzcAfSd5LxXfgZmMZHDtRBJMlQ04XnDJEKMuwT5zO9BLMk5dralNux9i
GnKiJnJgFv5xdPOpSYsivIp25f++lZun78H+afVSpf26rYM7BxTci126JJqndzMwf34pg+fd
+p9yB03tdNjcnwEzpoMzVB2sFntge5zEh2zhzgqpqQNm+sbVjp22r/jW5cRImLKFYNB72tPH
4tKVmo4wunFAKrRcDQhYNYp/mDsYxvXeU4npWEtAiJ4Cls3jJg3jbW/yC52guOTposhTUKGY
JRDAeQNS4zpZavxV/YAxFTqLbf/u55HwNzeWn7El82sSoAKMoHAEvzZKxMBh7gWwZnpAYRrm
rpdh5TTimE1I3MCNYk7inFmuGLTjembCuJ7TN5FdnSJtvXr9ztdmThvkgtmuPq95G0EsWjyK
lAkIJqWFNmkSmifHLp/IlgApC00gioW4v2uvYY0VPtQ4ByPVRwPjOktak9SMZyaD4Re9Dkv5
DEYCgTBjzmsdtGHy1bT7DWpSLMgMb3HmAwNZ0hvNwCL/S9o93NUCbopFEQfokuoGGJ5KVjQq
3F67IkWYkIIYq2o0e/y2tzS9B01rflcEOMQzklGNEMqNDsFluw1HHFniGHBsisfUuwV7YWal
5PkfzLo8t2/G3XNgOMdcbmjStyJ1jtrwheWX1duLacAHjX0ARi9YNeM92W/7zZzBalcGb/vy
uTuVWCxQlzAtfHfxDhbM/K9HpSQp0jy5a7XAaIyIIsU09Hrq9aofdCGkkj4yhtGcko7hYoiB
xHySIsO1y6BNTrdacjt6e8i9M3XfsXIY8/FIH5zn+9Xu6a/1oXzCt4/fnstXGLbcHI4FqrJU
/bzhn2C5iphAiD2U8+ukPU/NDvG9g+IzWM/O5oqZV3vNU0DwzoO2GYjD1BjsQpCje6RZP/Cp
WiXTfkLVijUKUS/nbuhRnlLjRpiUAoLn9E9GXW/UvVKb/lOIX46jQoRACAZq4+rJyoIl1Tx6
aJ5gXAaTZECxK/rbxcKORIR14UN/dxjmFQRtJQb59VnX9sLhq3K7dpNJoLphYteOCel6TPRX
vsPopMFJjhQT8M7QuQoO0bp7yfjmeIal8l2oCu5ZLQjIFyY5zHkRuK05BB7Q8+jQYalpwqv3
QppkSzrt+/sFIzP02wwz94Te51z6pzO+FGsBmsIUz4koRjExc4JURCDyPWdXUYY0ytwBagFI
pbDff36oHX5KYT+FxFo0j/H2LJ5n8L5CHr989zhASOu9ZozyiFu+BUh5DDqIWo9vSJg+8YzP
lqgDaVW/gfvo8SgRaaQBi1ikfZZW0cwMJj/uyE53GU4+7lQyz0I6Xe90LsFniMzqSWM40gKf
YxZEhhZBYFkSnxyBn7qd9CxNndarjAGedm9xlb8E71G7IblYevYPd87B3Ts8VjTdI556bzJZ
YZAYB1N0SjH09ukmqqrcESqzeWFogMyEivlvn1fgsYO/K/Tzutt+Wb841RvtSpC7foMwLxV2
VHRqJOf6sGYPMT+3zajb2EXlbXNBH6i5mRjl01+pYnEDgkf/B/+XIjvLjXIKV5L3S0R67ypn
/HazF1DiBJ9bbSdo3iRVgmd2YYVQlUZ6awiErVVYUqCo4qCz95gkcBJ3dbnBWA1UwXT0ocqw
rmJBs4kcOt6GC0MQ/0sWctTBSGWn/SkGZFuM/ZkOs1MDSon/kRYZqhJLuF0qHzIv1MpWu8Pa
IFP9/bW0MBUsS3ODNBr8a58lAbCVdjz+Mjq+PMMhVHRujATMzjkeAK/8DE9C6DkOFQp1hicO
kzMcanJuJRBTybMHo/JzhzsjMhk4mCa0jaylODb1Qc1vP54Z35JOH1eT4elJj62Gyb0boGGb
CUmraknRlTdZUgeduKiyL1jX4hYIW8TZw9jFJQ1hHPlTaO58bcRa6YfKwLblKZqSunjSpZv8
Q0U/RfP2XYCZYEOdbaLb23VKRAM6oIVMFh4HmiLAAJwXkyzDgkAShhJhtakAswLkNnNhLoC9
l09vh9Xnl9KUqwem7OBgXcWYp1GiEZ5Yj2Bx5BbU4C8DuduHJIQzdamcdffVWIpKnumj5oQr
6g5Zg/j29oYWa3aSlN+2u+9BstqsvpbfvAFinaiyDgMa4OBCkzsD69BHwRFRupjkWe+4Z4xl
pl7FvU2VxYCAMm2uEXCpurvudgMYifZV0MQKkuHl9moUGlHnE9nLMhrQC+hmnLvFPirx9G9u
w+DDhKdGKO6uLz7dNhwpA23JsDQHcPTMSRVRiC9SSkCfvKYhAoyuMQgeMBz+p4HHTAi/o3oc
534v+WhwgPDVGjRxbPUqW4ffjj0Im0IRjIJnQ5WvcAC4/6O61grz5VlV9L8py+d9cNgGf63+
KYMKIUYKhBMl8tmD/zLNqriCONBvWFK7W7HUQ83GmKBkaRNKm1Wl5eHf7e5vgIvHcg6iNmPa
lTRsKUJOfGKWp9yC5PgLdNSRBdPW7909MMU+TLaMpKVq+Asw8ET0muoCwe5hDRtVPi4yEXPq
R1aGp9INv2xWg8BtcqU5HaiOZRhQ+ApSuXP8PKsqGSlxcSS0tylBKQDA+l6AgClLM2cw+F2E
U3rciOWlWW8GbJdE+nUMd8Azfoo4QbvMknzp5cGtmaX7ymceIIYQYsaZY2eqYeeaD04aCX+B
EZ5qQabDNKb8O+HVnAP5BkNFybS9KjRpmjXN7kh5mA1LsuGQZHGGA6lwrpin8Esozg5/7bLG
npW3PDQf23mHxmg39LsPT2+f108f3NGT8EYNFaln89uBt0roOXRx+M0V5nUSIv3v7A0PxNcm
zAf9SrIhiwrMVdbIH5RkJ4gglSEdWCc+rVDtp8mB6gENsjMQMfgfGePRwAxjycPJYLW2EQxF
+toCTd7B5jFJi48Xo0t/oWrIKPT2ry+mo4ENkdh/d8uRvzQAwOJAPcZUDE3PGWO47pvrQRtg
QLh/W3QgpIbLICbI9IeIGUvnasE19RuQucLvkwY+SoEVAcyeDet0ksXDPiJV/imnyi++Zv9m
pRD8D3LEVwA3Fb6KDnHdSz08QUrdD20sklwiNnwo3Hr18X3cQw7BodwfeuUH2D+baYBV3ujp
qGePYIMR66BIIknIhXczlPgDz4F0B4lgf3JInyMsEvccy4Jjslw5joxGExRip9KmOoqG0MK9
z2WD8cyTXkKoYbDC1boFIUdhSkbx6bl6D7PsUzTjA5X0eO6fBoA04ZGfwLJpMZShSiP/EWWK
YEpwGDFEflq80Hmaep/QJlLAWqovFLrggPAYg1FfQkJPNcQAjVb2Ii6KHx38aUpX60fVf9ZP
ALZN+YkFcetqSSux0P9RfzSp3MbuC5PuTCg3IRhoje/5HKhEZYkzjGnx1bu3NPOOrsjAF3ku
Gwb4P8TcfVE0yAgxh9+p4eYTr9FACj4hzXpfPPATlQLmKHU+4DuAyIXfqiEtk370aGhEcb/n
MLuDOypAEs1b98BlGZ6BqzE0fFg7PcMPHXTFyOQI/+P3EFWxDrIfJ1yh7Wm7Oey2L/hl33Mr
385pRBr+ezlUSAcM+Ln1yTo5s9QlfgOxPFpDWO7XXzcLrEHA5dAt/EVZHzPUxv0UW5V52X6G
1a9fkFwODnOCq9r26rnE710MuTuavff7CtwVJSGDGyoyTOLgQQye0p9/jC6Zh6WpcTs7c5vo
9N9ae6Ns8/y6XW/6a8XqfFME5c+e2h3bofb/rg9Pf/2AjKhFDTd0v8DLGn94NMuhLOOiZwOt
iSiRgx9NSZLx0HzN1jm7quk4mYJvQ+un2qAH4rj8L6++aJqyOBvQK0BMOskin7UGB5yGJHbe
ijNZjRhxmSyIrEo4wsbBROvdt39Rtl+2IAY7eyXRoogFpjC9x9rv2GZ/4lgszMOPk8Js125q
0iWfD27OMLC5HKhKrhgwIVUPU1TVfifSY+aNPNfCFJUcV4EgeZ7H8IOMwVLoJuS3n/OOr6wt
7Ho2Ltq5Q2UKG7HYbEigkik/pllFWc2glngKACB06EuvSaoGJtI+sQ21FXCLyL4hEWG2Sw/8
Mx9AxaSxdso/oLHKQHpJMzH+02moM/NOm5P1h99OCkpg8YFics7Cospf26utkv6+RBYQsRCv
SShQMWUSNKFfPICfwrSfn2RE1t/MWMlD0+SZoH7i9D2vpnkc4w8/uq+ZouF3USSjmVcK9gwh
/NVo6U9iNcx5r2a4R46FsFJudqtJjJvykLuPx8OaJ1OBfCdnD+X49F7SM3S1/Hhi9ZIkx4vH
io5q3Ze3PpoJQK5Gf9xa26KhFAnGeDSc+xeE9bQoUgjUT6743I6lWh5jjnSeMAcd9I8J6d7o
BAhFP6ppwk970AqSrPdPPsME5jh5QGUbSHqQVA98oKp5lBiL7qUCEImFysG5oJryoX9yYZoV
EBd5SQpubBDANPjh6B8f6hI8BuIVKowGyryzeYYfqflDyVFfv6u3QQYOI/Hhr4pSfLqiy1vv
jfS6WlON/7i8ODrH6t+MKd9X+4Bv9ofd2zfzzfP+L/Cvz8Fht9rscZzgZb0pg2e42/Ur/tWG
l/+P3lXB78uh3K2CKJuQ4Evj0p+3/27QrQfftvhUHPyCX12sdyVMMKK/OidBp/77xNdMwAIU
/yUI6o93DIvUajnIMSVjkpKC+P9RFUfI3bq00CmBhZ9Hp43lMXXn46/eTO1MIkIX0fEQ/wEl
7799gh2sFyvs7pRfmRb8t2WKqH3BMiuopw4O31/hmOFy/v5PcFi9lv8JaPgbiNCvPiOh/IaH
TmVFHi6VMWQ/gmh7+yPeljyQgTQ7hL8jAh3IQxqWWEwmQ0lzw6Ao5kH7HxB0J6YbeXYRl+ma
8eMbclkieo6Dm/+eYVL4j7edZ4n5GP44wSOz/6PsyZbb1pV8n69Q3Yepex9yYy225UeIiwSb
mwhKovzC8nGUxHWcOOVl5ubvpxsgJYDshjKnKskRurEQS6O70QvVTBf4pve5/+XO464LlHXa
5xrCvXEYqA7i4vHT1stYLxdTg+9Hmp1DWmT1xIOziCYeYLtfp7umhv/0AeR7WhXMO4OGQhs3
NcNAdQjelRJ9+a8HFoF/eEIG194BIMLNGYSbmQ8h3Xq/IN1uUs9KhUXVyAlzN+v+8SUPNo4H
owxShrhoeATjmzBehNFSaAKbRbuB9r2Pg15VzMv4Ecc/FUU1PYcw8R/cVJRVsfbM5yZWq8C7
XyvJ8NTm5GwUkEqGYTGD3Je0/tGMkGN22supno5vxp7xxUZ9zF7NhlYykbcMMEOLOS9ccLo9
8wlV5Nnuap9eToM5EAb6MbAdoGc/rvUEN+PJ3DOIdSLOEbkwmN5cMm7Q+lzgQG+u6edCjZGp
Yur5il14Pb7xTAWvpzZ8R3qGOBXp/OKC9rk27feufPt+6rFQR8m6srkflKlQ/WgppbAIw4Bl
tisLFoLotcjR5QA9e1yQdmvsNVto/ZJhBSzV5f8+vX+HEf/8pOJ49PPh/el/DqMnDB709eHR
8QfWjYgVt8s7qNayolKclhkRI4i29A2koeu8lLTUpfuIFf0ypoFwUoLx1YTZAXqIeD2d+Qwl
k4mzB62ZhVk6sqUwYY/9mXz8eHt/+TEK0aqNmsUixJATjM2b7n2tONWVGVzNDW2RGk7aDA5K
6BFqNMdfETeHlJ5JS+knGg3LPDAU7aRiogW2M+0DMjRTA7c7HrhJPKu7lZ7J30oQnNVQCCr+
fDr1gRXMCAwwZR6uNLCsmNvOgCtYKS+8mF9d02upEYI0vJr54PsCdY48QhQLJoaWJl7AMVzR
RkVHuG94CK8nNF9zQqDDZWi4rOaT8Tm4ZwC3qQxKxshdIwBDA9IEvW81QhZVgR9BZreCucYM
gppfz8a0IY5GyJOQPbEGAZgmjspoBKBDk4uJbyWQUkE/PALaanBsrkEIGQ2TPsCMeGyAqMIu
0YjM0zwQjyuGISl89MPcqLlayYVngqpSxklE+Y8VLRVxNd9QtpPZIs/CIfGQ+aeXn8+/+wRk
QDX02bxgOUmz/fwLb7aOZ1ZwZ3gW3Xd5m0W970fEcJ7rvj48P//18Pj36PPo+fDt4fG39Rpp
3Tfti9JgCn0SC70VTSwGXuEabxTlx4S2aaPx9GY2+mf89HrYwZ9/UQrMWJYRWgXRbbdADP7V
G3TnRuLrxvo2EcgMt2T7UkdpzoCsgJCPGuMTY5e1X+68q8AW5PRGWqtNQvAzlhtOdI/W2vue
eYnUxrz0UdcGthGjsIavRttGWgdTsKBtzUFwVzG2MQtRRpuQvjiXjBUnjE8xSnKk8XmmcsZC
qtrQA4TyZqsXTQebZ2pvuQeVLEk5n7aybwRqDDee3t5fn/76wCQTyrzsC8vX0rEU6Iw4/rCK
ZaWFzraVuym3URbmZTMNcucRcpuXnKha7YtVTjqmWe2JUBRV5JCNtkiHpIh7B5VoYBm5pyWq
xtMxReXtSokI0PHKTQigEhnkijmpp6pV5LryiCDiFA6IjNFl1LmPSMW97enjgFy3yzScj8dj
9oWuwF1DBh6124TDn1XufSfWjBehXa8M6DHijskdGzJRJZyhckKL2wigTw9CuPk9s9CLMhdh
b8suZrQ6YhGkSG6YF4Sspr8n4Na+kss8o9lWbIwRzvaqitL+k5xdkXqLdz8YjaOc782Ev05r
TUUubSC2cpPSoFWUKNf0py1qKnqJj2B6Wo5gen1O4C1lAGiPTKrAGVf/gBJVtCOecyKWUSoz
eSSH9PXbAwwbDl3ipq9PkGYpfxa7Vmsfe+oomdD2FGqThX1rxWF7GHwscuIqLKLJ2bFH98HK
zR9jSpqswHCvGdDe1MQOONcSup6i9a2zMTE6U5wKiujoWE5r4BDd/YXF9RJdudOehVm3ZlJk
IM326+AA2TrWMJd5vkzog7DaiF0kSRDG+atrGpRV7jtVRMeww+KLPt4Fk9NjSeu+oXxL24vL
mqsCAKaTGds7Te5u0zNbsJWy7Y9Mt1ezaV2zl1m67S/ZadvfLRkt1N3+zO2XwihEljunIU3q
WcM9viT1JS+NAFTtvOB4d2Y8MijdTXKn5vPLMdSlVQ536n4+nw1MB+iW8/4Rhm+/hln/g5oK
CCC5q9N9KZ3Zg9/jC2ZB4kgk2ZnuMlG1nZ0IpSmiuWY1n84n1Dmy24wqTB/kBj6YMNtpW5PO
XW5zZZ7lKU0dMnfsEqhU9P+jkPPpzYV7UUzuzq9wtpWhy8eZ3FC9EzWsmN85IwZ80svaqtH6
EUfZUmauY+gK2FfYZeTE7iO0iY3lGc6yiDKFEZDIyTWPVXaP60RMuSfldcKyZNBmHWUNB16T
vpr2QDZo1ZM63OQaCuB6FUyEzfTswpeh82nl1cXszM4uI5QrHPZgPp7eMLYPCKpyetuX8/HV
zbnOMny8JhemRM+7kgQpkQJn4rjgKrxs+rSeqBnZkd9sQJ6AQAh/HCZCMXoKKG9iXK4zO0/J
RLg0IriZXEzH52o5JwB+3nDPuVKNb84sqEqVsweiQgbs83CK8cMZfbcGzs5RRpUHQBcxnSQ5
zZUm/s7nVSnyXOeXbuNmcBNFsU8jJjoRbg8m1G8glALWmz7DkkpTYQ9in+UFyFEO97wLmjpZ
9k7psG4VrTaVQxhNyZlabg3ZBAWwBOgrrSL626uE5HqtNnvaaPjZlCsgvPTtJfHtOIFlrShb
cKvZnbzP3PAQpqTZXXIb7ogwJTlXq3FjiOpEdDCmqUgeE8kFbDA4opY8GW1xkgTWg8OJw5Cx
pJRFQTq/rfaJXFhv6jsoOf2MJcYHN0XGsFjKEfzsnv0JnxyR6gq0qiJEixIO2CpkeIR6Pr++
uVqwCJ2ig0cI0svZGN8ieAQ00/LB57P5fOxFuPY0EMhAhPwnthI4Cw/FVvo+UAZFslEsOKkr
vipKaU29E3u+OhpxVeOL8ThgcVoJ5ywcWGUeRwsDXrDm6P8Ao+KX6sjesxgmTrXgR5LV0MOt
gJuIX/G1t4uWjfHANefBw4H78E4F3oY8sAIRm3l3R6Ut0DUZ8J2HBYogEy+8CuZjfg10C7O5
H351fQZ+w8JbwwcW3tLUJZC1SYl/EyQSxe/GvFGdCKMuNDGo2pI87jQ1vXqlKyiYmrJaCOY1
yyAEqY6Pz9B5jbOSaKfH3gUaB1Y/gJ0umacqRJHFenYxdjhgQ+pR7ZB+PL8//Xo+/KdH5bvv
xwwSJj4QRtrkckQ4yCnGqVoOuisC5blVANrURT+U0dHDc1DVqlkwVpY9/aPubfXy9v7p7enL
YbRRi6NxPmIdDl/a+AcI6SJBiC8Pv94Pr0MPgl1iZ6PCX6fHntTILRSsct5iMGMCb9sH0EtO
OnYbTe1ozzbIehkgoJ0GmQB1Kj0GVIJA4TDBuaqYQGlFKVV6SRl/2Y2e9GYUMALxn51TW/9D
gEvhRmFwYEcZkwLaHh82wDZztMsrBv9+H9qipQ3SHFGUuSr5HfeAnNb47MUJ/WRMitPtr0K6
1WybDk6J/Pnr4511npFZsXEjhWFBE8fou5lwRlgGyaTuvkuZzWKQUoGxQ/tIemSbt8PrM6ZX
PlopOlSkrZ9vVMSFnTEot/nejxBtz8F7x9aauEFMj17du2i/yDmbBesT/OPHyG/0a4lB0XHc
mQhHBiHfBCsFnBijEm5HAkSC0frIGe3otnp4/aLdzOTnfDT05EGFJUEOCF9djeq8Vok0Gr4b
trcE1e3RoIXa0WZU3x9eHx6Rxp/cKTsOqdo74iml48LAgTfA31R764gbcyC2sHVqnVwevVqT
UHvTbdARVxxd99Xh9enheWiJhNMCTKt2yQ7sF/UWMJ/YqfSsQiuDdZflg8bT2fhA3BZQ1MsU
a6PFeBfcEbNiIwXG4ITuyAlqYwOiWpQ0JCubjSgrK/ioDS0xCn4a+VB0rMnQDfRsw1ORYXSp
siIdAS1EtRJl1Hq2ky2FEQb8Z91xnXEr6v3amWyVsP0wRsV2+9VkPmf0aQYN+FvKjM54Nb/8
/ITNQInekpprIszO2qZw8vuqEBfDDa9rFVrbpd/qrWJS6xqwkrFkrKg6jCDIGGGoxWhNWW4r
gUZlNPF0Uc+htQJIoc5iAv3zgcuCcSAxYJ0EqDjXh8aSGVqInkMNUHmK+QRCuZQB0CU6SkiP
Rg2ayYzHaMhddzrVrs5mt9o2iz1aKzHsT9YsmQ2Q5fc594iGURoqJoB9m30V2ENapbY1uUl9
s6QD6TMhQKDbNpEqI7qWQIG7/U7fwEUqG5MhnonAtPPlnBZFgcZedODkbS/QBpTc0REmdGoN
11N6R0R4ObXTj69RBfCnoMcI5yPZc4FShnezPQj8bljDjaq00+swlI1hySYBRamwmOrSRrew
p8zZLBiPjYLZjyvGz6xwHe2MwFwVo8fnl8e/yQhRVdGML+dzzHLisoEmtIGO5zcy2t8RMsxs
dNP3F6h2GL1/P4wevnzRYe7hQOuO3/5tm1gOx2MNR2ZBVdLvAMtC5lwcvx1tQ2XCxmFMGCbo
VRdWrkiot4DVLnWfxHVBG1kIRcXhBWc8yAjFhIrgfJaqEWp6zTxWdRi1BBkMQ61glhHmPejY
WhFx6d9bFLgNlZAYuLxkrEN6iIWiAxN3ePrIouGdF0te3jUiZRxPW5xU1OObaz9KeX05uaCF
1Q4nq4IG7c5AxGB9xzrUQivuvThKqsvLG9r9pMPZSnE1v2I8qTqcaj6ZMhlqcbTMU99OYEjU
nIo/rtTCzhx96lEtCOxFgCkvCPRFL+i80eKhAu/rx89HnZ+CV7ClcWg0RQ3e/gFzZZywVknA
+MEgToq0lkmOC+CVvJpNxg1QQSZLZBXoSIgBvUESTJDIONogjHPCwa7NM0eR0oQDMW5Fdt8E
ac5ZXSHOHRwTxolIf351NWUOAILLMJhy3loIV+kl444rFvXlxTB+jFt7rwIuuwuAK3RInk4v
66ZSgfCsYbVO6zkTSBvA23rez7fcxWXxbTnrho6WmAyWOdll4PlKVPg1AZrHm9QgHiwCw3j2
vD78+v70SIZXFEvKMnW7RDdG6620LdDBbpeY7mJ8ZfFLhJgkoMwOytTlh7SKTUy+14cfh9Ff
H1+/AmsTDqM4xQty3slqJkzdw+Pfz0/fvr+P/nsE53aoujsdnyAElkEo1b54kDOLOdMSrYnh
UbtYdmd6PgbZ6y+HRQXzDeF9tpLhUPUIhc61LkMMrA2C2B5TqEXZkrGxBERgWknQZiXJuI/Q
9Mnby6hjfh0eUdbBCgSBxRpihgIMN4RGBCWTqUBDCy5ysYZuSs7IRE9DlNxJmiggOICLq6Sl
IAMGOSHzwPPNknGfRXAqMOawp7o+qjzY47uLcFi7ZZ6VnEs2okSpamLaLliDk4i78TT4vpco
w4Euo3QhGfFVw2PG8VADQXCWOSMhIsJWbkXCGnXgTbTXiloeYc9Py04knFu26TvaqZyzFNTD
35eD3LUOApo78P1z5jAIuxULhoNAaLWTGacJMNOSgeC+rDxDSwItJvDwKMu3NAtgNvVSBrwe
3qAkFed0beD7GAgov3ZlZPY234K2Ychj+gbUGDm+x3m2r3689W+hjPGtRRi6vjH6EYAWIkOe
GDY5fz6KqBLJPuMJX4H6JSaWjoYnAiWqjMt00+LsdUIcz2QWpYSrnAWDEOX71NbYk4ejRJew
yiTEYF1KW2iUoFqJi62IOJsM7X/4/cSpHfAo40MP8Nz8mdNBj27zvbeLSnrODBAbxcm1Gr5C
dY1JDMEibfCuBmmWlg0Qo5ZZyg/iPipz7yfggywbLEFPhJYEmxUT/11fx0k/NFKnEKW4hOMT
lcXUHF+QQDjMMYJMIqsqwSyWcFdajzoIb5lcm/fB4k1SDKIMW+Bjnq5VEPaqMjXMc4x5aQUk
reY/sTrH8uL777enR/jI5OE3Hbg7ywvdYB1EckvOk6cd9yOXIlwyaqBqXzCOzlixzGE2PTlV
0pSRjYCZYN9Ws2gHFweTicck+pY6yDRnhBfLTC5ERvGcEWzLLgeiAlbREkU06LQLOhkKxGjH
uhMLNMvuFq2CKld7urCzfPrH6/vjxT9sBHTThI3p1moLe7VOUl0VDC1aLFjWqp31XoEC9x3f
QgQxPjZhDN3+dTkG2iSKe5Ga7fJmIyPtH0jLojjqcjuIPntUIONIe+cAVb9MMapbmVrF88M7
ZnXswQYjAcaD3mIdQqjGE0Z4t1Aux7SawUa5pOmshXI1v2xikUqGw7cwr2f0I9UJZTK7oB1f
OxRV3Y2vKzH3IqWzeXXm6xFlSisDbZTLGz+KSq8mZz5qsZ7NL/woZXEZMBqfDmU7vZjQ+uUO
436frdOh6vrl56eg2PQ2VK8qEbfkuNOMX7S357iC/7tgwrMcv/F6ejHMNoQ3njr8fHt5Pbfl
l3kSxpJhlkNUOG77cadNsIhULDaxlSTypFjYZ0GDucm5JqFeg6kF4LqqZMxYoBo03kyvRVhF
guEIegO0rotNHUpV9GLbn+4wzo0PM6TyAVfad8U0yjauc4Uu5oL0dLVSrtOwoAwUtjpBy6Av
Xcq5kxuoCSVimB0ifk4b5fzx9eXt5ev7aPX71+H103b07ePw9u7otY6xov2op+6BDx4+OHY7
phJs8GLv/kSHuTyDu5fh/neYe5l8qQv0i5p6+Xhl9PYnY3hZXc1ozSDZiNWGkMkip9xTJYx7
YzEWTlAkDRwVD98OJicxkfTmHKq55w8/Xt4Pv15fHsnzH6V5heHU6QdZorJp9NePt29ke0Wq
uv1Mt+jUtBYf9ZD9oEnmUoex/VP9fns//BjlP0fB96df/xq9IaP/9Zg35HjFix/PL9+gWL0E
VKAaCmx0uK8vD18eX35wFUm4ebysi8/x6+HwBqz0YbR+eZXrQSPtN643Mgha91Zycs61pRt7
+ndac8McwOz36OTp/WCgi4+n5y9oWN3NIjFYNCGq0ZGve1IdmEF00fj/uHXd/Prj4Rkmkp1p
Em7vk6BxFSa6cv30/PTzP1ybFPQoMv7R9joNQKdm28ZlRJuVRTUGeeJEm5xRA0uG8GcVLQRj
ugo2m9KOsCku16NH+DLCnrhc99330VRJMgYa/XasT0DvbXZQ2pqA2UmGN1/tgW799aYXwt6H
XR4hj09Yc5dnAqVO3lkGDS+6lF5VXmKimrN44Z80pkTCqGQQC02+ZFrP03Vf7nfQUllHCfxd
SH+nRS2ayTxL0ZKFCZNoY+GMkMvoTrZVG1W2AWMenjLJVUsmlDf0Phsss/j55fXl6YvzHpiF
Zd4PoNzR6xbdYvgEGeihlWztn0cB9nSadHHZM7QynPIOU3k8Yo5RyrKSSXtonrv7z16dumnY
5KmmzghCNRlzsbBlzhhgJDLlTp32FglMaiuGc9pkA23gMTOfY0hv3k6fgNKbbeNcFluRyFBU
EQy/0U4GlHEawIBTEZarCBDLSeOuUVvU1Ji5gaOw04bMzwaQ2bC5mR5UrmTdiIBWQXRYKgo2
Jac90kiceuV2EU7sfvE3iww9pYtABCvHwKSMJMwbwJjkEbc8qOZBy1hNONii8nSXycRTNZ7w
NQFCn9KoRka3v0CmrFkgg97kBbWwKEY2CJeZlYk9RctWIOb7PtweCRBpzLHFvUwABkhytFN7
rIxkeuox7BdIUwC0LnIjQgmPULve5BUTy3xT5bGacRNrwOy0wyA4WJvFrQc2J/jh8XvPAELp
vUnLOgbboOscOp8x1RfSBYIsSJXfXF1dcKPahPEA1PVDt210Drn6HIvqc1Tj33CRM72nCjC5
vrdQl4PphtlzURFL0JFM38gMm/N2+PjyMvrqjLi7fY8ZjOyCO9daX5ehEVKV9AoLgQGB8kxW
ubMXNRB4vCQsIyokxF1UZnavPb2vTobpGBRjwRmCanAGNPzECMdhE5QR3Bh2y+YffnqJyTs2
iS48SAZMeENnwHkpsmXEHxwRemAxD1t5QTpUAEd4PaNZ8CBPraAUKZd0aL0RasUdA8/VgbEJ
a5aipJ6vL3jYOqtnXugVDy19nRZoxsp4oOzVlqVBnukuh9S2IwKtPbe74zqgruX+3k56v6cO
Y6pL2NOkwbTiHkFqJyiLuhJzUWX9gYRSoWsi0N6CetgEFOpxbKmdNQr0CAwtpzq4cfs/YaBu
h0Y51/v6WTNpFJxYk4fXoj2brCwcTbkp8WiAdaZ67lRIDpCHgj/yPE+UMJsok9Ai5XEl82Zn
PNSOiX0tDrp1NHz8eH16/00p0e8iLiVUy6k2YRopLV5XICRzPkUerrYDkttcu4KuRAmibhRq
JifIi71OQhyI3jUzQKOZlP+r7Fqa28aR8F9xzWmnypOKndiTOfjAByQy5kPmw5J9YSkyx1bF
llSSPLvZX7/dDYIESTTkPUxljP4IAQ2g0UA/gClYQGHK0zJj7B7kSOJRNTEwdfxUs1LGmodn
O1Y4ml0yyuOb3/BiFl9bPP+1fFue45uLu/Xm/LD8u4Z61k/naP98Rt6f/9j9/Zscjtt6v6lf
z16W+6d6g4e3bljktXj9tt3/Oltv1sf18nX93yVS9fjssMAugC6byIeiO1Xcg006Kqdhgv6S
Jezgwrmlfpo1dyPcfciE2dXOgscRYw6I0No0kSPacpTRlRUYM62yWGURMHNJkXkmd6Ftg1Wh
GCyfzFW35d7+1+64PVvhg+/b/dlL/bqjZ7Z7YOje1Jlpsa694stReX7rhbNAl0sDwviTALZY
Y+EYmiXT3lGxKZapHJnXIyVkOFWMFbQSHu3pueGHMCrP9iv0D/MGZsO3sghEYr6AaiBGY/7s
/cfrevXHz/rX2YrG7Rn9kn/pAk/xiHlusCEPn8zqU4V3ip759vrzmMnE3XCozO7F5dWVIa2L
8358qTfH9WqJufDFhvqJjvr07o9zOGxXayL5y+PS0HHPY/LVSfLUTvYCOLg5l59nafRw8eWz
2QCvBlFMQ3RjsPJB3A0diIasDBwQC/cjPrhkE3vbPvWPlqqdrnXyeEMX/AGZuRhqyZyK3DTZ
WnmUmT3VG3Jqb9rsRM8W9rbBdj/PmOtXNWxosi1K6zRAN6jxkATLwws/IlyeIyXKTtAXJzp+
P/i+eWniuT4cR9Lay7wvl55BchHB2opFwDn8Ngg3cm7FpXUMJcQ6TtCQ4uKzH5o3YrVWT7Xl
I6s09plM9Yp84usrjPG2QkJYwmR8sMKy2L+4NrugKFkROExK/o5+qjEKg+68J3CXV2YPpB7i
g3VdXVhnFSCY1wTUbmEnF6AvuSlzepGY+WzQBrlE17uXgVW2Fd7W+QnkivEq1xAfYI5LmZXt
09hzMN0549ncYvLCOlMRYB1Q397jCf37kb3Rvt9lM84y2A62dUEW83TILzl827fdvj4c5Flh
3LlJ5DDRGmpfejRbGRvyN8ZNrv3a2mogB9aF+ZgX4yCxbLl52r6dJe9vP+q9dEZRh6HRdEvw
TetZxnj3KDZk7pTcmWyg7yGGnAk0JDNnTE1brkC/r07J4Rao1PsPgU/0pcU5whmzrjm2vK5/
7JdwTNpv34/rjXFjjkL3IzsSwuQMP4kyKq9jnNqdMBXbo7i5MFb2kS2sa5pZMR0oGnPDxo8+
xEE4Sao//7oyW0E1INrcPYeJ9dBwhROFBePoq8FyZyIWHpNlWcN5mMvrFMiJ5avI00U0nhP1
/og+J3A8OFAqxMP6ebOk97NWL/XqJxyTdZ+Wj8AJH1kmGfpsDFzuGoobwraFTo6a7UG5YsCO
lnizh2qSpbEyfRkgkUgYKibMK4sw6h9P08xnlBCMHRJwcI1ds9dl6yPiha2JWWO/B4MDUsM4
6byL6yHYqtp5VViUFVPXl8HBHgowQfdkeBruA6LQE+7DN8OnksKJboI42ZzfORABA8lRr9ma
WYI57B6WuFTauc++GXovlfV+ahvMKmPn2SOKE0yiJG1HqgGPuL68NKZYVr38q7Ec9zMjYfHY
PKfU+7tafLselZGzzGyMDZ3rr6NCJ4tNZUUAc3pEwDyN43pd77vOrKaUYVPXt2r6qGfn1Agu
EC6NlOgxdoyExSODT5nyr8ZyZH9HwCApWLW6A48sQuNE1XMYwXJfb1sihF/l5AeOIaXTQruF
ayOwkIjuZ7GTa+lGsRTahK89gOwJSKfo5WQCOm7gnBeHf6dZYKdR6vbueuFv2zROIrSNjiWj
DECiCdTdu2Z3uNFGhmpgMUz8QufPvWjruvfzdPwLU1FgBqJ04juaI0OOzl9pZGDeDH2meren
LQkomYDxQRvPzCnwAetpYsCVMjSrmkRlHii/F/XDIJ8GAhtNGcnUyL129xttav27e7VbUulu
v94cf1Jg0NNbfXg2GVpkqjDKzcTtQEjHSHvzHaxMJFZF+LrXvYjU/fjNnyzirgxF0SVJjIFD
aMEf1fBVm5IPiYPxaZZ4CB0xyvGhGPwQuynsLZXIMoALfY3iZ/Af7PxumgvdcsWysT3grF/r
P47rt0YBORB0Jcv3JqbLXwNhbspIOsmgZdXcyZKbi8+XX/vTY1Y5OTr4xZy3qePTHbjDJK0L
BKbQARmD+fGMK0u2LRceug6he0GMGYb0rIl9CrW0SpOol7VU1kIPJlWTMpGf0DKpvjC3UPon
c7TgzASmoSqNy+DDXO+FFjTLxK9/vD8/o/Ul3ByO+/e3etNPFktB+Gg9Z1JoNk1lLYckAG6n
fk8y4t+GDzph4eZOAnpNEhZw7kDLVC96FqlGVnyoc/3RRc8XPdG2LEVXEmVeasxYbWV93RlW
K6UzHT4WPWAQAsnAZpYsWE06T5hjJ5FnaYiZIrgHmulXUve74K6+86h0FczcUkKg5ZUdzIZl
lGXauR1PckWxNFGaRUsUc+ZGwM7gNyiRUN4UJhBY1ndvSpjY7foSE2ZF6UTj9jYES/XSX5/M
nnamUIvRxW4SpfPxL/XI9rXi5Hrw+YCAl+g4jTSLokc9ldQuzLBPRUcV3E+TtFtUvt+ovd2y
dLiFNVoDo/4Fgxy78nIf8Wfpdnc4P4u2q5/vOymaguXmeXAGTUDKgFxMzc6fPTp6Gpfi5rM2
adJJgZ4n5azJ+JuanQUoGXBQJvj6e08NbAzZLYmUgLQsbi4utZ/BJJegljuxBqSWmc7OHHbc
+vmdMXWd5oRt46L0HwG5//T+SlmpOjHVW1I0Tj0VC4tHy70zvhuqHI46culWiNlAKskrBzT+
dRL4X4fdekMpLc/P3t6P9X9q+J/6uPr06dPvXVPJ/5fqnpL6N3ZOmmUYLtr4+ZoPolgH9suy
rPFMURZiwVwoN3PaEDHYFw6yivFqn88lDURqOgetmAmplU2Z54JRYSSA+sPvHRKkkhZEMBon
6kLG0k1no1ubf5t+FdZRUWZidMDspm7bUaOi3s60iaUqpc3/H/NlpD5md5PImbIhpd4tZRo2
dwF1NmBvVSaYOQVWiiWhb7PNyX2WEXc/pfLxtDwuz1DrWOF9nEHnjUKGXY3GcIKe2xQB8jwP
BxdlnRwjHaDyncLB40FWGnzje7KH6dLwV70M+IcPjPVd5KShwCvNKhQQKnqzmZ9lCDk5FRGE
bk4fqYudDEgVd7npcKViV3v9GC38u0Zrzwz6ev98RQsMVEe8EzY3Fa+3Eu9hkD9M1wva4wT1
KBtoDS11mjmzwIxRZ8UJUYcVyPzcMUUIAXPxdnYAQS90XDyEBBVVvlWgI7zmQ1mL5lMOX/Rl
vDr0qaa0jBh0k1/lNgDICFATJtY6aKO0AII5jIkNIBI6cip9QiKZUI0m+blkIJPAnL6v8sSZ
5UFq0kBdEFagG8KuSPEvQ3dDVe4kIBHo1Qn5AbPvtXAYUSvQjW7JlhGmlsWUPyRFUIl7EAlc
KqgceRROpxyTumlVubAWgtjJmPfpnXgWCZPqqJ0FKPQvzGkznQttKkvHWUNO9jDt00Zibbf9
d73frZjTITotN554c5FlRq0UQZKox3Jgj+WU9sWsCG6utcsPdDMGXRI0Rv6KrJtk+MIk6MVW
WJyHlbyDs+OwrXgTifo23aRabqEWMXPMdP3QlhSK3iPAh1UsQnjMdf3qr6gPR1QhUEf2tv/U
++Vz3XOoLhPGHqK2zYrGA0593+UNj5m3tMSNmOHUu/XS+9GZDM5aUNy8gdB3eEe8oT71tAqO
Dw79MOsHlpNaAQPEpOwlSBwmlC2FR7Dfu0qXooli2WZd9Hix0OnOPo1STNrBoih2Fc5Llb0y
dWFun7zUsUAs/JJJwC57Li+epcc5I5QaXO4xzgcEuAVEwcTrEoAWudnESHS5IHl6WQ4DpnXq
wskyJq0N0U13EX1EhqY5esPKwk7OrYKooc/EN4eJj907IdMlnynMzcIFX3Dpe+RcF7EHe7Z1
xMkAzogEVYkdQO7weE3HRFGJmD33WIXWyFdeGjX+B3QirkQU7gAA

--ikeVEW9yuYc//A+q--
