export interface InitParams {
    sdkHash: string;
    userId?: string | null;
    uaNetwork?: string | null;
    uaChannel?: string | null;
    uaSubPublisherEncrypted?: string | null;
    uaSubPublisherCleartext?: string | null;
    placement?: string | null;
}

export interface ShowCatalogParams {
    uaNetwork?: string | null;
    uaChannel?: string | null;
    uaSubPublisherEncrypted?: string | null;
    uaSubPublisherCleartext?: string | null;
    placement?: string | null;
    subId1?: string | null;
    subId2?: string | null;
    subId3?: string | null;
    subId4?: string | null;
    subId5?: string | null;
}

declare namespace _default {
    function initialize(initParams: InitParams): Promise<void>;
    function showCatalog(params?: ShowCatalogParams): Promise<void>;
}

export default _default;