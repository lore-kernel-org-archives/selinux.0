Subject: Re: Filtering an avtab in libsepol
To: Gary Tierney <gary.tierney@gmx.com>, SELinux <selinux@tycho.nsa.gov>
References: <20161206170055.GA30914@workstation>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a351189a-cf18-0345-ec36-f2978f563c4a@tycho.nsa.gov>
Date: Tue, 6 Dec 2016 12:53:00 -0500
MIME-Version: 1.0
In-Reply-To: <20161206170055.GA30914@workstation>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/06/2016 12:00 PM, Gary Tierney wrote:
> Hi,
> 
> I've been working on optimizing out AV rules with no applicable
> types as well as unused attributes to trim down the size of a
> policy which uses CIL blocks and attributes extensively.  Looking
> into the avtab code (and how creating a new avtab is implemented in
> expand.c) I have a question:
> 
> Does the following suffice for taking an existing avtab and
> creating a new one with all of its elements?  Or do I need to
> consider avtab_insert_nonunique() like expand.c does?  If I'm
> following the expand_avtab() code correctly, I'd think I'd need to
> consider conditional avtabs in the following code:
> 
> static int copy_avtab_map_fn(avtab_key_t *key, avtab_datum_t
> *datum, void *args) { avtab_t *avtab = (avtab_t *) args;
> 
> return avtab_insert(avtab, key, datum); }
> 
> static int copy_avtab(avtab_t *avtab, avtab_t **out) { avtab_t *tmp
> = NULL; if (avtab_init(tmp)) { return POLICYDB_ERROR; }
> 
> if (avtab_alloc(tmp, MAX_AVTAB_SIZE)) { return POLICYDB_ERROR; }
> 
> if (avtab_map(avtab, copy_avtab_map_fn, tmp)) { return
> POLICYDB_ERROR; }
> 
> *out = tmp; return POLICYDB_SUCCESS; }
> 
> Is that the right idea?
> 
> Thanks.

Did you consider doing this at the CIL layer instead, given that CIL
already does similar optimizations and has more semantic information
available?  Note that CIL used to be more aggressive about removing
unused attributes but backed off because some attributes are used in
neverallows and we want to preserve those for neverallow checking in CTS.

Conditional rules can indeed have non-unique entries, and so can
xperms rules.
