const status100Continue = 100;
const status101SwitchingProtocols = 101;
const status102Processing = 102;

const status200OK = 200;
const status201Created = 201;
const status202Accepted = 202;
const status203NonAuthoritative = 203;
const status204NoContent = 204;
const status205ResetContent = 205;
const status206PartialContent = 206;
const status207Multistatus = 207;
const status208AlreadyReported = 208;
const status226IMUsed = 226;

const status300MultipleChoices = 300;
const status301MovedPermanently = 301;
const status302Found = 302;
const status303SeeOther = 303;
const status304NotModified = 304;
const status305UseProxy = 305;
const status306SwitchProxy = 306;
const status307TemporaryRedirect = 307;
const status308PermanentRedirect = 308;

const status400BadRequest = 400;
const status401Unauthorized = 401;
const status402PaymentRequired = 402;
const status403Forbidden = 403;
const status404NotFound = 404;
const status405MethodNotAllowed = 405;
const status406NotAcceptable = 406;
const status407ProxyAuthenticationRequired = 407;
const status408RequestTimeout = 408;
const status409Conflict = 409;
const status410Gone = 410;
const status411LengthRequired = 411;
const status412PreconditionFailed = 412;
const status413PayloadTooLarge = 413;
const status414UriTooLong = 414;
const status415UnsupportedMediaType = 415;
const status416RangeNotSatisfiable = 416;
const status417ExpectationFailed = 417;
const status418ImATeapot = 418;
const status419AuthenticationTimeout = 419;
const status421MisdirectedRequest = 421;
const status422UnprocessableEntity = 422;
const status423Locked = 423;
const status424FailedDependency = 424;
const status426UpgradeRequired = 426;
const status428PreconditionRequired = 428;
const status429TooManyRequests = 429;
const status431RequestHeaderFieldsTooLarge = 431;
const status451UnavailableForLegalReasons = 451;

const status500InternalServerError = 500;
const status501NotImplemented = 501;
const status502BadGateway = 502;
const status503ServiceUnavailable = 503;
const status504GatewayTimeout = 504;
const status505HttpVersionNotSupported = 505;
const status506VariantAlsoNegotiates = 506;
const status507InsufficientStorage = 507;
const status508LoopDetected = 508;
const status510NotExtended = 510;
const status511NetworkAuthenticationRequired = 511;

const defaultRetryableStatuses = <int>{
  status408RequestTimeout,
  status504GatewayTimeout,
};

@Deprecated('Use [defaultRetryableStatuses]')
const retryableStatuses = defaultRetryableStatuses;

bool isRetryable(int statusCode) =>
    defaultRetryableStatuses.contains(statusCode);
